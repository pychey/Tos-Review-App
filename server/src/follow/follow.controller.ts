import { Controller, Get, Param, Post, Request, UseGuards } from '@nestjs/common';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { FollowService } from './follow.service';
import { ApiBearerAuth, ApiOperation, ApiTags } from '@nestjs/swagger';

@ApiTags('Follow')
@ApiBearerAuth()
@Controller('follow')
export class FollowController {
  constructor(private followService: FollowService) {}

  @ApiOperation({ summary: 'Follow or unfollow a user' })
  @UseGuards(JwtAuthGuard)
  @Post(':userId')
  followUser(@Request() req, @Param('userId') userId: string) {
    return this.followService.followUser(req.user.id, userId);
  }

  @ApiOperation({ summary: 'Get followers of a user' })
  @UseGuards(JwtAuthGuard)
  @Get(':userId/followers')
  getFollowers(@Param('userId') userId: string) {
    return this.followService.getFollowers(userId);
  }

  @ApiOperation({ summary: 'Get following of a user' })
  @UseGuards(JwtAuthGuard)
  @Get(':userId/following')
  getFollowing(@Param('userId') userId: string) {
    return this.followService.getFollowing(userId);
  }
}