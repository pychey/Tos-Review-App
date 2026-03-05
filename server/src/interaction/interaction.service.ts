import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { RatePostDto } from './dto/rate-post.dto';
import { NotificationService } from '../notification/notification.service';

@Injectable()
export class InteractionService {
  constructor(
    private prisma: PrismaService,
    private notificationService: NotificationService,
  ) {}

  async likePost(userId: string, postId: string) {
    const post = await this.prisma.post.findUnique({ where: { id: postId } });
    if (!post) throw new NotFoundException('Post not found');

    const existing = await this.prisma.like.findUnique({
      where: { postId_userId: { postId, userId } },
    });

    if (existing) {
      await this.prisma.like.delete({
        where: { postId_userId: { postId, userId } },
      });
      return { liked: false };
    }

    await this.prisma.like.create({ data: { postId, userId } });
    await this.notificationService.createNotification({
      userId: post.authorId,
      actorId: userId,
      type: 'LIKE',
      postId,
    });
    return { liked: true };
  }

  async savePost(userId: string, postId: string) {
    const post = await this.prisma.post.findUnique({ where: { id: postId } });
    if (!post) throw new NotFoundException('Post not found');

    const existing = await this.prisma.save.findUnique({
      where: { postId_userId: { postId, userId } },
    });

    if (existing) {
      await this.prisma.save.delete({
        where: { postId_userId: { postId, userId } },
      });
      return { saved: false };
    }

    await this.prisma.save.create({ data: { postId, userId } });
    return { saved: true };
  }

  async ratePost(userId: string, postId: string, dto: RatePostDto) {
    const post = await this.prisma.post.findUnique({ where: { id: postId } });
    if (!post) throw new NotFoundException('Post not found');

    await this.prisma.rating.upsert({
      where: { postId_userId: { postId, userId } },
      update: { value: dto.value },
      create: { postId, userId, value: dto.value },
    });

    const ratings = await this.prisma.rating.findMany({
      where: { postId },
      select: { value: true },
    });

    await this.notificationService.createNotification({
      userId: post.authorId,
      actorId: userId,
      type: 'RATING',
      postId,
    });

    const avgUserRating = ratings.reduce((sum, r) => sum + r.value, 0) / ratings.length;
    return { avgUserRating };
  }
}