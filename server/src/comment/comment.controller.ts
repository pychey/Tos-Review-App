import { Body, Controller, Delete, Get, Param, Patch, Post, Request, UseGuards } from '@nestjs/common';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { CommentService } from './comment.service';
import { CreateCommentDto } from './dto/create-comment.dto';
import { UpdateCommentDto } from './dto/update-comment.dto';
import { ApiBearerAuth, ApiOperation, ApiTags } from '@nestjs/swagger';

@ApiTags('Comments')
@ApiBearerAuth()
@Controller('comments')
export class CommentController {
  constructor(private commentService: CommentService) {}

  @ApiOperation({ summary: 'Create a comment on a post' })
  @UseGuards(JwtAuthGuard)
  @Post(':postId')
  createComment(@Request() req, @Param('postId') postId: string, @Body() dto: CreateCommentDto) {
    return this.commentService.createComment(req.user.id, postId, dto);
  }

  @ApiOperation({ summary: 'Get comments by post' })
  @UseGuards(JwtAuthGuard)
  @Get(':postId')
  getCommentsByPost(@Request() req, @Param('postId') postId: string) {
    return this.commentService.getCommentsByPost(postId, req.user.id);
  }

  @ApiOperation({ summary: 'Update a comment' })
  @UseGuards(JwtAuthGuard)
  @Patch(':commentId')
  updateComment(@Request() req, @Param('commentId') commentId: string, @Body() dto: UpdateCommentDto) {
    return this.commentService.updateComment(req.user.id, commentId, dto);
  }

  @ApiOperation({ summary: 'Delete a comment' })
  @UseGuards(JwtAuthGuard)
  @Delete(':commentId')
  deleteComment(@Request() req, @Param('commentId') commentId: string) {
    return this.commentService.deleteComment(req.user.id, commentId);
  }

  @ApiOperation({ summary: 'Like or unlike a comment' })
  @UseGuards(JwtAuthGuard)
  @Post('like/:commentId')
  likeComment(@Request() req, @Param('commentId') commentId: string) {
    return this.commentService.likeComment(req.user.id, commentId);
  }
}