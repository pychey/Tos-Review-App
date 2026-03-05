import { IsEnum } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';
import { ReportStatus } from 'src/generated/prisma/enums';

export class UpdateReportStatusDto {
  @ApiProperty({ enum: ['REVIEWED', 'DISMISSED'], example: 'REVIEWED' })
  @IsEnum(['REVIEWED', 'DISMISSED'])
  status: 'REVIEWED' | 'DISMISSED';
}