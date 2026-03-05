import { Body, Controller, Param, Post, UseGuards, Request } from '@nestjs/common';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { ReportService } from './report.service';
import { CreateReportDto } from './dto/create-report.dto';
import { ApiBearerAuth, ApiOperation, ApiTags } from '@nestjs/swagger';

@ApiTags('Reports')
@ApiBearerAuth()
@Controller('reports')
export class ReportController {
  constructor(private reportService: ReportService) {}

  @ApiOperation({ summary: 'Report a post' })
  @UseGuards(JwtAuthGuard)
  @Post(':postId')
  createReport(@Request() req, @Param('postId') postId: string, @Body() dto: CreateReportDto) {
    return this.reportService.createReport(req.user.id, postId, dto);
  }
}