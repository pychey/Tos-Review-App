import { IsString } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class GoogleMobileDto {
  @ApiProperty({ example: 'your_google_id_token' })
  @IsString()
  idToken: string;
}