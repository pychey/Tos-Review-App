import { BadRequestException, Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { CreateReportDto } from './dto/create-report.dto';

@Injectable()
export class ReportService {
  constructor(private prisma: PrismaService) {}

  async createReport(userId: string, postId: string, dto: CreateReportDto) {
    const post = await this.prisma.post.findUnique({ where: { id: postId } });
    if (!post) throw new NotFoundException('Post not found');

    const existing = await this.prisma.report.findUnique({
      where: { postId_userId: { postId, userId } },
    });
    if (existing) throw new BadRequestException('You have already reported this post');

    return this.prisma.report.create({
      data: { postId, userId, ...dto },
    });
  }

  async getAllReports() {
    return this.prisma.report.findMany({
      orderBy: { createdAt: 'desc' },
      include: {
        post: { select: { id: true, productName: true, authorId: true } },
        user: { select: { id: true, name: true, email: true } },
      },
    });
  }

  async updateReportStatus(reportId: string, status: 'REVIEWED' | 'DISMISSED') {
    const report = await this.prisma.report.findUnique({ where: { id: reportId } });
    if (!report) throw new NotFoundException('Report not found');

    return this.prisma.report.update({
      where: { id: reportId },
      data: { status },
    });
  }
}