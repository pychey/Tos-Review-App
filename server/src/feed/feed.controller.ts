import { Controller, Get, Query, Request, UseGuards } from '@nestjs/common';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { FeedService } from './feed.service';
import { FeedQueryDto } from './dto/feed-query.dto';
import { ApiBearerAuth, ApiOperation, ApiTags } from '@nestjs/swagger';

@ApiTags('Feed')
@ApiBearerAuth()
@Controller('feed')
export class FeedController {
  constructor(private feedService: FeedService) {}

  @ApiOperation({ summary: 'Get personalized feed' })
  @UseGuards(JwtAuthGuard)
  @Get()
  getPersonalizedFeed(@Request() req, @Query() query: FeedQueryDto) {
    return this.feedService.getPersonalizedFeed(req.user.id, query);
  }

  @ApiOperation({ summary: 'Get following feed' })
  @UseGuards(JwtAuthGuard)
  @Get('following')
  getFollowingFeed(@Request() req, @Query() query: FeedQueryDto) {
    return this.feedService.getFollowingFeed(req.user.id, query);
  }
}