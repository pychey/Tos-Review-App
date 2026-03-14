import { IsOptional, IsString, IsUrl } from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class CreateAdDto {
  @ApiProperty({ example: 'Best Skincare Product' })
  @IsString()
  title: string;

  @ApiProperty({ example: 'Try our amazing skincare product' })
  @IsString()
  description: string;

  @ApiProperty({ example: 'https://res.cloudinary.com/...' })
  @IsString()
  imageUrl: string;

  @ApiPropertyOptional({ example: 'https://example.com/product' })
  @IsOptional()
  @IsUrl()
  linkUrl?: string;

  @ApiProperty({ example: 'Nike' })
  @IsString()
  brandName: string;

  @ApiPropertyOptional({ example: 'https://res.cloudinary.com/...' })
  @IsOptional()
  @IsString()
  brandLogo?: string;
}