import { Request, Response } from 'express';
import { asyncHandler } from '../../shared/utils/asyncHandler';
import { authService } from './auth.service';

export const authController = {
  register: asyncHandler(async (req: Request, res: Response) => {
    const result = await authService.register(req.body);
    res.status(201).json({ success: true, data: result });
  }),

  login: asyncHandler(async (req: Request, res: Response) => {
    const result = await authService.login(req.body);
    res.json({ success: true, data: result });
  }),

  me: asyncHandler(async (req: Request, res: Response) => {
    const user = await authService.getProfile((req as unknown as { userId: string }).userId);
    res.json({ success: true, data: user });
  }),

  updateProfile: asyncHandler(async (req: Request, res: Response) => {
    const user = await authService.updateProfile((req as unknown as { userId: string }).userId, req.body);
    res.json({ success: true, data: user });
  }),
};