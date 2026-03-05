import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { FeedQueryDto } from './dto/feed-query.dto';
import { formatPost, postInclude } from 'src/post/post.utils';
import { AdService } from 'src/ad/ad.service';

@Injectable()
export class FeedService {
  constructor(
    private prisma: PrismaService,
    private adService: AdService,
  ) {}

  async getGeneralFeed(query: FeedQueryDto) {
    const { page, limit, category } = query;
    const skip = ((page ?? 1) - 1) * (limit ?? 10);

    const posts = await this.prisma.post.findMany({
      where: { ...(category && { category }) },
      orderBy: { createdAt: 'desc' },
      skip,
      take: limit ?? 10,
      include: postInclude,
    });

    return posts.map(formatPost.bind(this));
  }

  async getFollowingFeed(userId: string, query: FeedQueryDto) {
    const { page, limit, category } = query;
    const skip = ((page ?? 1) - 1) * (limit ?? 10);

    const following = await this.prisma.follow.findMany({
      where: { followerId: userId },
      select: { followingId: true },
    });

    const followingIds = following.map((f) => f.followingId);

    const posts = await this.prisma.post.findMany({
      where: {
        authorId: { in: followingIds },
        ...(category && { category }),
      },
      orderBy: { createdAt: 'desc' },
      skip,
      take: limit,
      include: postInclude,
    });

    return posts.map(formatPost.bind(this));
  }

  async getPersonalizedFeed(userId: string, query: FeedQueryDto) {
    const { page, limit, category } = query;
    const skip = ((page ?? 1) - 1) * (limit ?? 10);

    const [interests, likes, saves, views, following] = await Promise.all([
      this.prisma.userInterest.findMany({
        where: { userId },
        select: { interest: true },
      }),
      this.prisma.like.findMany({
        where: { userId },
        select: { post: { select: { authorId: true } } },
      }),
      this.prisma.save.findMany({
        where: { userId },
        select: { post: { select: { authorId: true } } },
      }),
      this.prisma.postView.findMany({
        where: { userId },
        select: { postId: true },
      }),
      this.prisma.follow.findMany({
        where: { followerId: userId },
        select: { followingId: true },
      }),
    ]);

    const interestKeywords = interests.map((i) => i.interest);
    const followingSet = new Set(following.map((f) => f.followingId));
    const viewedSet = new Set(views.map((v) => v.postId));
    const engagedAuthorSet = new Set([
      ...likes.map((l) => l.post.authorId),
      ...saves.map((s) => s.post.authorId),
    ]);

    const posts = await this.prisma.post.findMany({
      where: {
        ...(category && { category }),
      },
      orderBy: { createdAt: 'desc' },
      include: {
        ...postInclude,
      },
    });

    const scored = posts.map((post) => {
      let score = 0;

      if (followingSet.has(post.authorId)) score += 5;

      const matchesInterest = interestKeywords.some(
        (keyword) =>
          post.productName.toLowerCase().includes(keyword.toLowerCase()) ||
          post.description.toLowerCase().includes(keyword.toLowerCase()),
      );
      if (matchesInterest) score += 4;

      if (engagedAuthorSet.has(post.authorId)) score += 4;

      if (viewedSet.has(post.id)) score -= 5;

      return { ...formatPost(post), score };
    });

    const sorted = scored.sort((a, b) => b.score - a.score);
    const paginated = sorted.slice(skip, skip + (limit ?? 10));

    const formattedPosts = paginated.map(({ score, ...post }) => ({ type: 'POST', ...post }));

    const activeAds = await this.adService.getActiveAds();
    if (activeAds.length === 0) return formattedPosts;

    const randomAd = activeAds[Math.floor(Math.random() * activeAds.length)];
    return [{ type: 'AD', ...randomAd }, ...formattedPosts];
  }
}