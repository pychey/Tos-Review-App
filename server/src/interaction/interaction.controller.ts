import { Body, Controller, Param, Post, Request, UseGuards } from '@nestjs/common';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { InteractionService } from './interaction.service';
import { RatePostDto } from './dto/rate-post.dto';
import { ApiBearerAuth, ApiOperation, ApiTags } from '@nestjs/swagger';

@ApiTags('Interactions')
@ApiBearerAuth()
@Controller('interactions')
export class InteractionController {
  constructor(private interactionService: InteractionService) {}

  @ApiOperation({ summary: 'Like or unlike a post' })
  @UseGuards(JwtAuthGuard)
  @Post('like/:postId')
  likePost(@Request() req, @Param('postId') postId: string) {
    return this.interactionService.likePost(req.user.id, postId);
  }

  @ApiOperation({ summary: 'Save or unsave a post' })
  @UseGuards(JwtAuthGuard)
  @Post('save/:postId')
  savePost(@Request() req, @Param('postId') postId: string) {
    return this.interactionService.savePost(req.user.id, postId);
  }

  @ApiOperation({ summary: 'Rate a post' })
  @UseGuards(JwtAuthGuard)
  @Post('rate/:postId')
  ratePost(@Request() req, @Param('postId') postId: string, @Body() dto: RatePostDto) {
    return this.interactionService.ratePost(req.user.id, postId, dto);
  }
}