import { BadRequestException, Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { CreateReportDto } from './dto/create-report.dto';
import axios from 'axios';

@Injectable()
export class ReportService {
  constructor(private prisma: PrismaService) {}

  async createReport(userId: string, postId: string, dto: CreateReportDto) {
    const post = await this.prisma.post.findUnique({
      where: { id: postId },
      include: {
        author: {
          select: {
            createdAt: true,
            _count: { select: { posts: true } },
          },
        },
      },
    });
    if (!post) throw new NotFoundException('Post not found');

    const existing = await this.prisma.report.findUnique({
      where: { postId_userId: { postId, userId } },
    });
    if (existing) throw new BadRequestException('You have already reported this post');

    const report = await this.prisma.report.create({
      data: { postId, userId, ...dto },
    });

    try {
      const reportCount = await this.prisma.report.count({ where: { postId } });

      const accountAgeInDays =
        (Date.now() - new Date(post.author.createdAt).getTime()) /
        (1000 * 60 * 60 * 24);

      const response = await axios.post('http://localhost:8000/predict', {
        text: post.description,
        rating: post.authorRating,
        review_count: post.author._count.posts,
        account_age: accountAgeInDays,
        report_count: reportCount,
      });

      const { risk_level, confidence, explanation, signals } = response.data;

      await this.prisma.post.update({
        where: { id: postId },
        data: {
          riskLevel: risk_level,
          riskConfidence: confidence,
          riskReason: explanation,
          riskRules: signals?.applied_rules ?? [],
        },
      });

      console.log(`[FraudAPI] Repredicted post ${postId} after report → ${risk_level} (${(confidence * 100).toFixed(0)}%)`);
    } catch (e) {
      console.warn(`[FraudAPI] Repredicton failed for post ${postId}:`, e.message);
    }

    return report;
  }

  async getAllReports() {
    return this.prisma.report.findMany({
      orderBy: { createdAt: 'desc' },
      include: {
        post: { select: { id: true, productName: true, mediaUrls: true, author: {select: {name: true, profileSrc: true}} } },
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