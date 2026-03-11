import { Body, Controller, Delete, Get, Param, Post, Query, Request, UseGuards } from '@nestjs/common';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { PostService } from './post.service';
import { CreatePostDto } from './dto/create-post.dto';
import { Category } from 'src/generated/prisma/enums';
import { ApiBearerAuth, ApiOperation, ApiTags } from '@nestjs/swagger';

@ApiTags('Posts')
@ApiBearerAuth()
@Controller('posts')
export class PostController {
  constructor(private postService: PostService) {}

  @ApiOperation({ summary: 'Create a post' })
  @UseGuards(JwtAuthGuard)
  @Post()
  createPost(@Request() req, @Body() dto: CreatePostDto) {
    return this.postService.createPost(req.user.id, dto);
  }
  
  @ApiOperation({ summary: 'Search posts' })
  @UseGuards(JwtAuthGuard)
  @Get('search')
  searchPosts(@Query('q') q: string, @Query('category') category?: Category) {
    return this.postService.searchPosts(q, category);
  }

  @ApiOperation({ summary: 'Get view history' })
  @UseGuards(JwtAuthGuard)
  @Get('history')
  getViewHistory(@Request() req) {
    return this.postService.getViewHistory(req.user.id);
  }

  @ApiOperation({ summary: 'Get related posts' })
  @UseGuards(JwtAuthGuard)
  @Get(':id/related')
  getRelatedPosts(@Request() req, @Param('id') id: string) {
    return this.postService.getRelatedPosts(req.user.id, id);
  }

  @ApiOperation({ summary: 'Get post by id' })
  @UseGuards(JwtAuthGuard)
  @Get(':id')
  async getPostById(@Request() req, @Param('id') id: string) {
    await this.postService.recordView(req.user.id, id);
    return this.postService.getPostById(id, req.user.id);
  }

  @ApiOperation({ summary: 'Get posts by user' })
  @UseGuards(JwtAuthGuard)
  @Get('user/:userId')
  getPostsByUser(@Param('userId') userId: string) {
    return this.postService.getPostsByUser(userId);
  }

  @ApiOperation({ summary: 'Delete post' })
  @UseGuards(JwtAuthGuard)
  @Delete(':id')
  deletePost(@Request() req, @Param('id') id: string) {
    return this.postService.deletePost(req.user.id, id);
  }

  @ApiOperation({ summary: 'Share post link' })
  @UseGuards(JwtAuthGuard)
  @Get(':id/share')
  sharePost(@Param('id') id: string) {
    return { link: `${process.env.APP_URL}/posts/${id}` };
  }
}