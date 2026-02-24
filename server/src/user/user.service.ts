import { BadRequestException, Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { Provider } from 'src/generated/prisma/enums';

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
    if (existing) {
      if (existing.provider === 'LOCAL') {
        throw new BadRequestException('Email already in use with a different sign in method');
      }
      return existing;
    }

    return this.prisma.user.create({
      data: {
        email: data.email,
        name: data.name,
        profileSrc: data.profileSrc,
        provider: 'GOOGLE',
      },
    });
  }
}