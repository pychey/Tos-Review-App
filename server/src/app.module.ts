import { Module } from '@nestjs/common';
import { AuthModule } from './auth/auth.module';
import { PrismaModule } from './prisma/prisma.module';
import { UserModule } from './user/user.module';
import { ConfigModule } from '@nestjs/config';
import { UploadModule } from './upload/upload.module';
import { PostModule } from './post/post.module';
import { FeedModule } from './feed/feed.module';
import { InteractionModule } from './interaction/interaction.module';
import { CommentModule } from './comment/comment.module';
import { FollowModule } from './follow/follow.module';
import { NotificationModule } from './notification/notification.module';
import { AdminService } from './admin/admin.service';
import { AdminModule } from './admin/admin.module';
import { ReportModule } from './report/report.module';
import { AdModule } from './ad/ad.module';

@Module({
  imports: [
    ConfigModule.forRoot({ isGlobal: true }),
    PrismaModule,
    UserModule,
    AuthModule,
    UploadModule,
    PostModule,
    FeedModule,
    InteractionModule,
    CommentModule,
    FollowModule,
    NotificationModule,
    AdminModule,
    ReportModule,
    AdModule,
  ],
  providers: [AdminService],
})
export class AppModule {}