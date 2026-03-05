import { Controller, Get, Patch, Param, Request, UseGuards } from '@nestjs/common';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { NotificationService } from './notification.service';
import { ApiBearerAuth, ApiOperation, ApiTags } from '@nestjs/swagger';

@ApiTags('Notifications')
@ApiBearerAuth()
@Controller('notifications')
export class NotificationController {
  constructor(private notificationService: NotificationService) {}

  @ApiOperation({ summary: 'Get my notifications' })
  @UseGuards(JwtAuthGuard)
  @Get()
  getNotifications(@Request() req) {
    return this.notificationService.getNotifications(req.user.id);
  }

  @ApiOperation({ summary: 'Mark a notification as read' })
  @UseGuards(JwtAuthGuard)
  @Patch(':id/read')
  markAsRead(@Request() req, @Param('id') id: string) {
    return this.notificationService.markAsRead(req.user.id, id);
  }

  @ApiOperation({ summary: 'Mark all notifications as read' })
  @UseGuards(JwtAuthGuard)
  @Patch('read-all')
  markAllAsRead(@Request() req) {
    return this.notificationService.markAllAsRead(req.user.id);
  }
}