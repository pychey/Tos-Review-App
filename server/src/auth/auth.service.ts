import { BadRequestException, Injectable, UnauthorizedException } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import * as bcrypt from 'bcrypt';
import { OAuth2Client } from 'google-auth-library';
import { UserService } from '../user/user.service';
import { RegisterDto } from './dto/register.dto';

const googleClient = new OAuth2Client(process.env.GOOGLE_IOS_CLIENT_ID);

@Injectable()
export class AuthService {
  constructor(
    private userService: UserService,
    private jwtService: JwtService,
  ) {}

  async validateUser(email: string, password: string) {
    const user = await this.userService.findByEmail(email);
    if (!user || !user.hashedPassword) return null;
    const match = await bcrypt.compare(password, user.hashedPassword);
    return match ? user : null;
  }

  async register(dto: RegisterDto) {
    const existing = await this.userService.findByEmail(dto.email);
    if (existing) throw new BadRequestException('Email already in use');

    const hashedPassword = await bcrypt.hash(dto.password, 10);
    const user = await this.userService.create({
      email: dto.email,
      name: dto.name,
      hashedPassword,
    });

    return this.signToken(user.id, user.email);
  }

  async login(user: { id: string; email: string }) {
    return this.signToken(user.id, user.email);
  }

  async googleLogin(googleUser: { email: string; name: string; profileSrc: string }) {
    const user = await this.userService.findOrCreateGoogleUser(googleUser);
    return this.signToken(user.id, user.email);
  }

  async googleMobileLogin(idToken: string) {
    const ticket = await googleClient.verifyIdToken({
      idToken,
      audience: process.env.GOOGLE_IOS_CLIENT_ID,
    });

    const payload = ticket.getPayload();
    if (!payload) throw new UnauthorizedException('Invalid Google token');

    const user = await this.userService.findOrCreateGoogleUser({
      email: payload.email!,
      name: payload.name!,
      profileSrc: payload.picture ?? '',
    });

    return this.signToken(user.id, user.email);
  }

  private signToken(userId: string, email: string) {
    return { access_token: this.jwtService.sign({ sub: userId, email }) };
  }
}