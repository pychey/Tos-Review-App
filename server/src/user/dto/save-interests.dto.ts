import { IsArray, IsString } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class SaveInterestsDto {
  @ApiProperty({ example: ['coffee', 'skincare', 'perfume'] })
  @IsArray()
  @IsString({ each: true })
  interests: string[];
}