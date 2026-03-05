import { IsEnum, IsNotEmpty, IsNumber, IsOptional, IsString, IsUrl, Max, Min } from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { Category } from 'src/generated/prisma/enums';

export class CreatePostDto {
  @ApiProperty({ example: 'Sunscreen SPF 50' })
  @IsString()
  @IsNotEmpty()
  productName: string;

  @ApiProperty({ example: 'Great sunscreen for daily use' })
  @IsString()
  @IsNotEmpty()
  description: string;

  @ApiProperty({ example: 4.5, minimum: 1, maximum: 5 })
  @IsNumber()
  @Min(1)
  @Max(5)
  authorRating: number;

  @ApiProperty({ enum: Category, example: Category.BEAUTY })
  @IsEnum(Category)
  category: Category;

  @ApiPropertyOptional({ example: 15.99 })
  @IsOptional()
  @IsNumber()
  price?: number;

  @ApiPropertyOptional({ example: 'Bangkok' })
  @IsOptional()
  @IsString()
  location?: string;

  @ApiPropertyOptional({ example: 'https://shopee.com/product' })
  @IsOptional()
  @IsUrl()
  productUrl?: string;

  @ApiPropertyOptional({ example: ['https://res.cloudinary.com/...'] })
  @IsOptional()
  @IsString({ each: true })
  mediaUrls?: string[];
}