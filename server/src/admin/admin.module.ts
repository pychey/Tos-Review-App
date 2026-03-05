import { Module } from '@nestjs/common';
import { AdminService } from './admin.service';
import { AdminController } from './admin.controller';
import { ReportModule } from 'src/report/report.module';
import { AdModule } from 'src/ad/ad.module';

@Module({
  imports: [ReportModule, AdModule],
  providers: [AdminService],
  controllers: [AdminController],
})
export class AdminModule {}