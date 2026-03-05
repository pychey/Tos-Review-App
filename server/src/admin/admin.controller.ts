import { Body, Controller, Delete, Get, Param, Patch, Post, UseGuards } from '@nestjs/common';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { AdminGuard } from '../auth/guards/admin.guard';
import { AdminService } from './admin.service';
import { ReportService } from 'src/report/report.service';
import { AdService } from 'src/ad/ad.service';
import { ApiBearerAuth, ApiOperation, ApiTags } from '@nestjs/swagger';
import { UpdateReportStatusDto } from 'src/report/dto/update-report-status.dto';
import { CreateAdDto } from 'src/ad/dto/create-ad.dto';

@ApiTags('Admin')
@ApiBearerAuth()
@Controller('admin')
@UseGuards(JwtAuthGuard, AdminGuard)
export class AdminController {
  constructor(
    private adminService: AdminService,
    private reportService: ReportService,
    private adService: AdService,
  ) {}

  @ApiOperation({ summary: 'Get all posts' })
  @Get('posts')
  getAllPosts() {
    return this.adminService.getAllPosts();
  }

  @ApiOperation({ summary: 'Delete a post' })
  @Delete('posts/:id')
  deletePost(@Param('id') id: string) {
    return this.adminService.deletePost(id);
  }

  @ApiOperation({ summary: 'Get all users' })
  @Get('users')
  getAllUsers() {
    return this.adminService.getAllUsers();
  }

  @ApiOperation({ summary: 'Ban or unban a user' })
  @Patch('users/:id/ban')
  toggleBanUser(@Param('id') id: string) {
    return this.adminService.toggleBanUser(id);
  }

  @ApiOperation({ summary: 'Get all reports' })
  @Get('reports')
  getAllReports() {
    return this.reportService.getAllReports();
  }

  @ApiOperation({ summary: 'Update report status' })
  @Patch('reports/:id/status')
  updateReportStatus(@Param('id') id: string, @Body() dto: UpdateReportStatusDto) {
    return this.reportService.updateReportStatus(id, dto.status);
  }

  @ApiOperation({ summary: 'Get all ads' })
  @Get('ads')
  getAllAds() {
    return this.adService.getAllAds();
  }

  @ApiOperation({ summary: 'Create an ad' })
  @Post('ads')
  createAd(@Body() dto: CreateAdDto) {
    return this.adService.createAd(dto);
  }

  @ApiOperation({ summary: 'Toggle ad status' })
  @Patch('ads/:id/status')
  toggleAdStatus(@Param('id') id: string) {
    return this.adService.toggleAdStatus(id);
  }
}