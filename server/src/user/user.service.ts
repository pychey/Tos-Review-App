import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { Provider } from 'src/generated/prisma/enums';
import { UpdateProfileDto } from './dto/update-profile.dto';

@Injectable()
export class UserService {
  constructor(private prisma: PrismaService) {}

  findByEmail(email: string) {
    return this.prisma.user.findUnique({ where: { email } });
  }

  findById(id: string) {
    return this.prisma.user.findUnique({ where: { id } });
  }

  create(data: { email: string; name: string; hashedPassword: string; provider?: Provider }) {
    return this.prisma.user.create({ data });
  }

  async findOrCreateGoogleUser(data: { email: string; name: string; profileSrc: string }) {
    const existing = await this.findByEmail(data.email);
    if (existing) return existing;

    return this.prisma.user.create({
      data: {
        email: data.email,
        name: data.name,
        profileSrc: data.profileSrc,
        provider: 'GOOGLE',
      },
    });
  }

  async getProfile(userId: string) {
    const user = await this.prisma.user.findUnique({
      where: { id: userId },
      select: {
        id: true,
        name: true,
        email: true,
        bio: true,
        websiteUrl: true,
        profileSrc: true,
        createdAt: true,
        _count: {
          select: {
            posts: true,
            followers: true,
            following: true,
          },
        },
      },
    });

    if (!user) throw new NotFoundException('User not found');
    return user;
  }

  async updateProfile(userId: string, dto: UpdateProfileDto) {
    return this.prisma.user.update({
      where: { id: userId },
      data: dto,
      select: {
        id: true,
        name: true,
        email: true,
        bio: true,
        websiteUrl: true,
        profileSrc: true,
      },
    });
  }

  async getSavedPosts(userId: string) {
    return this.prisma.save.findMany({
      where: { userId },
      orderBy: { createdAt: 'desc' },
      include: {
        post: {
          include: {
            author: { select: { id: true, name: true, profileSrc: true } },
            _count: { select: { likes: true, comments: true, ratings: true } },
          },
        },
      },
    });
  }

  async saveInterests(userId: string, interests: string[]) {
    await this.prisma.userInterest.deleteMany({ where: { userId } });
    return this.prisma.userInterest.createMany({
      data: interests.map((interest) => ({ userId, interest })),
    });
  }

  async getInterests(userId: string) {
    return this.prisma.userInterest.findMany({
      where: { userId },
      select: { interest: true },
    });
  }
}