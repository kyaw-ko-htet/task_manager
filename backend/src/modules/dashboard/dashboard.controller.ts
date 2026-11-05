import { Request, Response } from 'express';
import { asyncHandler } from '../../shared/utils/asyncHandler';
import { dashboardService } from './dashboard.service';

export const dashboardController = {
  summary: asyncHandler(async (req: Request, res: Response) => {
    const userId = (req as unknown as { userId: string }).userId;
    const { date } = req.query as { date?: string };
    const data = await dashboardService.summary(userId, date);
    res.json({ success: true, data });
  }),
};