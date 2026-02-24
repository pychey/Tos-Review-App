import { Body, Controller, Get, Post, Request, UseGuards } from '@nestjs/common';
import { AuthService } from './auth.service';
import { RegisterDto } from './dto/register.dto';
import { GoogleAuthGuard } from './guards/google-auth.guard';
import { JwtAuthGuard } from './guards/jwt-auth.guard';
import { LocalAuthGuard } from './guards/local-auth.guard';

@Controller()
export class AuthController {
  constructor(private authService: AuthService) {}

  @Post('register')
  register(@Body() dto: RegisterDto) {
    return this.authService.register(dto);
  }

  @UseGuards(LocalAuthGuard)
  @Post('login')
  login(@Request() req) {
    return this.authService.login(req.user);
  }

  @UseGuards(JwtAuthGuard)
  @Get('me')
  me(@Request() req) {
    return req.user;
  }

  @UseGuards(GoogleAuthGuard)
  @Get('auth/google')
  googleLogin() {}

  @UseGuards(GoogleAuthGuard)
  @Get('auth/google/callback')
  async googleCallback(@Request() req) {
    return this.authService.googleLogin(req.user);
  }

  @Post('auth/google/mobile')
  async googleMobileCallback(@Body('idToken') idToken: string) {
    return this.authService.googleMobileLogin(idToken);
  }
}