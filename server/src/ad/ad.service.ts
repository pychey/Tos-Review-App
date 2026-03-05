import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { CreateAdDto } from './dto/create-ad.dto';

@Injectable()
export class AdService {
  constructor(private prisma: PrismaService) {}

  async createAd(dto: CreateAdDto) {
    return this.prisma.advertisement.create({ data: dto });
  }

  async toggleAdStatus(adId: string) {
    const ad = await this.prisma.advertisement.findUnique({ where: { id: adId } });
    if (!ad) throw new NotFoundException('Advertisement not found');

    return this.prisma.advertisement.update({
      where: { id: adId },
      data: { status: ad.status === 'ACTIVE' ? 'INACTIVE' : 'ACTIVE' },
    });
  }

  async getAllAds() {
    return this.prisma.advertisement.findMany({
      orderBy: { createdAt: 'desc' },
    });
  }

  async getActiveAds() {
    return this.prisma.advertisement.findMany({
      where: { status: 'ACTIVE' },
    });
  }
}