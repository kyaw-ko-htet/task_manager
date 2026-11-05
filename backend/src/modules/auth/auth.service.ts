import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';
import { env } from '../../config/env';
import { authRepository } from './auth.repository';
import { ConflictError, UnauthorizedError } from '../../shared/errors/AppError';

export interface AuthUser {
  id: string;
  email: string;
  name: string;
  businessName: string | null;
  phone: string | null;
  address: string | null;
  currency: string;
}

function toAuthUser(u: {
  id: string;
  email: string;
  name: string;
  businessName: string | null;
  phone: string | null;
  address: string | null;
  currency: string;
}): AuthUser {
  return {
    id: u.id,
    email: u.email,
    name: u.name,
    businessName: u.businessName,
    phone: u.phone,
    address: u.address,
    currency: u.currency,
  };
}

function signToken(userId: string): string {
  return jwt.sign({ sub: userId }, env.JWT_SECRET, { expiresIn: env.JWT_EXPIRES_IN } as jwt.SignOptions);
}

export const authService = {
  async register(input: { email: string; password: string; name: string; businessName?: string }) {
    const existing = await authRepository.findByEmail(input.email);
    if (existing) throw new ConflictError('Email already registered');
    const passwordHash = await bcrypt.hash(input.password, 10);
    const user = await authRepository.create({
      email: input.email,
      passwordHash,
      name: input.name,
      businessName: input.businessName,
    });
    const token = signToken(user.id);
    return { accessToken: token, user: toAuthUser(user) };
  },

  async login(input: { email: string; password: string }) {
    const user = await authRepository.findByEmail(input.email);
    if (!user) throw new UnauthorizedError('Invalid credentials');
    const ok = await bcrypt.compare(input.password, user.passwordHash);
    if (!ok) throw new UnauthorizedError('Invalid credentials');
    const token = signToken(user.id);
    return { accessToken: token, user: toAuthUser(user) };
  },

  async getProfile(userId: string) {
    const user = await authRepository.findById(userId);
    if (!user) throw new UnauthorizedError('User not found');
    return toAuthUser(user);
  },

  async updateProfile(
    userId: string,
    input: { name?: string; businessName?: string; phone?: string; address?: string; currency?: string; password?: string },
  ) {
    const data: Record<string, unknown> = {};
    if (input.name !== undefined) data.name = input.name;
    if (input.businessName !== undefined) data.businessName = input.businessName;
    if (input.phone !== undefined) data.phone = input.phone;
    if (input.address !== undefined) data.address = input.address;
    if (input.currency !== undefined) data.currency = input.currency;
    if (input.password) data.passwordHash = await bcrypt.hash(input.password, 10);
    const user = await authRepository.update(userId, data);
    return toAuthUser(user);
  },
};