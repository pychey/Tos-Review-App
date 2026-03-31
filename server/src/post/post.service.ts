import { Injectable, NotFoundException, ForbiddenException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { CreatePostDto } from './dto/create-post.dto';
import { Category } from 'src/generated/prisma/enums';
import { formatPost, postInclude } from './post.utils';
import axios from 'axios';

@Injectable()
export class PostService {
  constructor(private prisma: PrismaService) {}

  async createPost(userId: string, dto: CreatePostDto) {
    const post = await this.prisma.post.create({
      data: {
        authorId: userId,
        ...dto,
      },
      include: postInclude,
    });

    try {
      const user = await this.prisma.user.findUnique({
        where: { id: userId },
        select: {
          _count: { select: { posts: true } },
          createdAt: true,
        },
      });

      const accountAgeInYears = user
        ? (Date.now() - new Date(user.createdAt).getTime()) / (1000 * 60 * 60 * 24 * 365)
        : null;

      const fraudResponse = await axios.post('http://localhost:8000/predict', {
        text: dto.description,
        rating: dto.authorRating,
        review_count: user?._count.posts ?? null,
        account_age: accountAgeInYears,
      });

      const { risk_level, confidence, explanation, signals } = fraudResponse.data;

      await this.prisma.post.update({
        where: { id: post.id },
        data: {
          riskLevel: risk_level,
          riskConfidence: confidence,
          riskReason: explanation,
          riskRules: signals?.applied_rules ?? [],
        },
      });

      return formatPost({
        ...post,
        riskLevel: risk_level,
        riskConfidence: confidence,
        riskReason: explanation,
        riskRules: signals?.applied_rules ?? [],
      }, userId);
    } catch (e) {
      console.warn('[FraudAPI] Skipped:', e.message);
      return formatPost(post, userId);
    }
  }

  async getPostById(postId: string, userId: string) {
    const [liked, saved, userRating] = await Promise.all([
      this.prisma.like.findUnique({
        where: { postId_userId: { postId, userId } },
      }),
      this.prisma.save.findUnique({
        where: { postId_userId: { postId, userId } },
      }),
      this.prisma.rating.findUnique({
        where: { postId_userId: { postId, userId } },
      }),
    ]);

    await this.prisma.post.update({
      where: { id: postId },
      data: { viewCount: { increment: 1 } },
    });

    const post = await this.prisma.post.findUnique({
      where: { id: postId },
      include: postInclude
    });

    if (!post) throw new NotFoundException('Post not found');

    const avgUserRating =
      post.ratings.length > 0
        ? post.ratings.reduce((sum, r) => sum + r.value, 0) / post.ratings.length
        : null;

    const { ratings, ...rest } = post;

    const isOwner = userId === post.authorId;
    const author = post.isAnonymous && !isOwner
      ? { id: null, name: 'Anonymous', profileSrc: null }
      : post.author;

    return {
      ...rest,
      author,
      avgUserRating,
      isLiked: !!liked,
      isSaved: !!saved,
      userRating: userRating?.value ?? null,
    };
  }

  async getPostsByUser(userId: string, requestingUserId: string) {
    const isOwnProfile = userId === requestingUserId;
    const posts = await this.prisma.post.findMany({
      where: {
        authorId: userId,
        ...(!isOwnProfile && { isAnonymous: false }),  // hide anonymous posts from others
      },
      orderBy: { createdAt: 'desc' },
      include: postInclude
    });
    return posts.map(p => formatPost(p, requestingUserId));
  }

  async deletePost(userId: string, postId: string) {
    const post = await this.prisma.post.findUnique({ where: { id: postId } });
    if (!post) throw new NotFoundException('Post not found');
    if (post.authorId !== userId) throw new ForbiddenException('Not your post');

    return this.prisma.post.delete({ where: { id: postId } });
  }

  async searchPosts(query: string, userId: string, category?: Category) {
    const posts = await this.prisma.post.findMany({
      where: {
        ...(query && { productName: { contains: query, mode: 'insensitive' } }),
        ...(category && { category }),
      },
      orderBy: { createdAt: 'desc' },
      include: postInclude
    });
    
    return posts.map(p => formatPost(p, userId));
  }

  async recordView(userId: string, postId: string) {
    await this.prisma.postView.upsert({
      where: { postId_userId: { postId, userId } },
      update: { createdAt: new Date() },
      create: { postId, userId },
    });
  }

  async getViewHistory(userId: string) {
    const views = await this.prisma.postView.findMany({
      where: { userId },
      orderBy: { createdAt: 'desc' },
      include: {
        post: {
          include: postInclude
        },
      },
    });
    return views.map((v) => ({ ...v, post: formatPost(v.post, userId) }));
  }

  async getRelatedPosts(userId: string, postId: string) {
    const post = await this.prisma.post.findUnique({ where: { id: postId } });
    if (!post) throw new NotFoundException('Post not found');

    const [interests, following, views] = await Promise.all([
      this.prisma.userInterest.findMany({ where: { userId }, select: { interest: true } }),
      this.prisma.follow.findMany({ where: { followerId: userId }, select: { followingId: true } }),
      this.prisma.postView.findMany({ where: { userId }, select: { postId: true } }),
    ]);

    const interestKeywords = interests.map((i) => i.interest);
    const followingSet = new Set(following.map((f) => f.followingId));
    const viewedSet = new Set(views.map((v) => v.postId));

    const candidates = await this.prisma.post.findMany({
      where: {
        id: { not: postId },
        category: post.category,
      },
      include: postInclude,
    });

    const scored = candidates.map((candidate) => {
      let score = 0;

      // BOOST POSTS FROM FOLLOWED USERS
      if (followingSet.has(candidate.authorId)) score += 5;

      const matchesInterest = interestKeywords.some(
        (keyword) =>
          candidate.productName.toLowerCase().includes(keyword.toLowerCase()) ||
          candidate.description.toLowerCase().includes(keyword.toLowerCase()),
      );
      if (matchesInterest) score += 4;

      const postWords = post.productName.toLowerCase().split(' ');
      const matchesPostWords = postWords.some((word) =>
        candidate.productName.toLowerCase().includes(word),
      );
      if (matchesPostWords) score += 3;

      // DEMOTE VIEWED POSTS
      if (viewedSet.has(candidate.id)) score -= 3;

      return { ...formatPost(candidate, userId), score };
    });

    return scored
      .sort((a, b) => b.score - a.score)
      .slice(0, 10)
      .map(({ score, ...post }) => post);
  }
}