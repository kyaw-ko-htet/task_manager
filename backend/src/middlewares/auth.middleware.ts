import { Request, Response, NextFunction } from 'express';
import jwt from 'jsonwebtoken';
import { env } from '../config/env';
import { UnauthorizedError } from '../shared/errors/AppError';

export interface AuthRequest extends Request {
  userId?: string;
}

export const authMiddleware = (req: Request, _res: Response, next: NextFunction): void => {
  const header = req.headers.authorization;
  if (!header || !header.startsWith('Bearer ')) {
    return next(new UnauthorizedError('Missing or invalid token'));
  }
  const token = header.slice(7);
  try {
    const payload = jwt.verify(token, env.JWT_SECRET) as { sub: string };
    (req as AuthRequest).userId = payload.sub;
    next();
  } catch {
    next(new UnauthorizedError('Invalid or expired token'));
  }
};