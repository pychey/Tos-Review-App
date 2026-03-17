import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class AdminService {
  constructor(private prisma: PrismaService) {}

  getAllPosts() {
    return this.prisma.post.findMany({
      orderBy: { createdAt: 'desc' },
      include: {
        author: { select: { id: true, name: true, email: true, profileSrc: true } },
        _count: { select: { likes: true, comments: true, ratings: true } },
      },
    });
  }

  async deletePost(postId: string) {
    const post = await this.prisma.post.findUnique({ where: { id: postId } });
    if (!post) throw new NotFoundException('Post not found');
    return this.prisma.post.delete({ where: { id: postId } });
  }

  getAllUsers() {
    return this.prisma.user.findMany({
      orderBy: { createdAt: 'desc' },
      select: {
        id: true,
        name: true,
        email: true,
        role: true,
        provider: true,
        createdAt: true,
        profileSrc: true,
        _count: { select: { posts: true, followers: true, following: true } },
      },
    });
  }

  async toggleBanUser(userId: string) {
    const user = await this.prisma.user.findUnique({ where: { id: userId } });
    if (!user) throw new NotFoundException('User not found');

    const newRole = user.role === 'BANNED' ? 'USER' : 'BANNED';
    return this.prisma.user.update({
      where: { id: userId },
      data: { role: newRole },
      select: { id: true, name: true, email: true, role: true },
    });
  }
}