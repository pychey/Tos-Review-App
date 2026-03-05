import { Body, Controller, Get, Param, Patch, Post, Request, UseGuards } from '@nestjs/common';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { UserService } from './user.service';
import { UpdateProfileDto } from './dto/update-profile.dto';
import { ApiBearerAuth, ApiOperation, ApiTags } from '@nestjs/swagger';
import { SaveInterestsDto } from './dto/save-interests.dto';

@ApiTags('Users')
@ApiBearerAuth()
@Controller('users')
export class UserController {
  constructor(private userService: UserService) {}

  @ApiOperation({ summary: 'Get my profile' })
  @UseGuards(JwtAuthGuard)
  @Get('me')
  getMyProfile(@Request() req) {
    return this.userService.getProfile(req.user.id);
  }

  @ApiOperation({ summary: 'Get saved posts' })
  @UseGuards(JwtAuthGuard)
  @Get('me/saves')
  getSavedPosts(@Request() req) {
    return this.userService.getSavedPosts(req.user.id);
  }

  @ApiOperation({ summary: 'Update my profile' })
  @UseGuards(JwtAuthGuard)
  @Patch('me')
  updateProfile(@Request() req, @Body() dto: UpdateProfileDto) {
    return this.userService.updateProfile(req.user.id, dto);
  }

  @ApiOperation({ summary: 'Get user profile by id' })
  @UseGuards(JwtAuthGuard)
  @Get(':id')
  getProfile(@Param('id') id: string) {
    return this.userService.getProfile(id);
  }

  @ApiOperation({ summary: 'Save interests' })
  @UseGuards(JwtAuthGuard)
  @Post('me/interests')
  saveInterests(@Request() req, @Body() dto: SaveInterestsDto) {
    return this.userService.saveInterests(req.user.id, dto.interests);
  }

  @ApiOperation({ summary: 'Get my interests' })
  @UseGuards(JwtAuthGuard)
  @Get('me/interests')
  getInterests(@Request() req) {
    return this.userService.getInterests(req.user.id);
  }
}