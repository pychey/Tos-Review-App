import { Module } from '@nestjs/common';
import { FeedService } from './feed.service';
import { FeedController } from './feed.controller';
import { AdModule } from 'src/ad/ad.module';

@Module({
  imports: [AdModule],
  providers: [FeedService],
  controllers: [FeedController],
})
export class FeedModule {}