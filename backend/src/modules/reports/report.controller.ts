import { Request, Response } from 'express';
import { asyncHandler } from '../../shared/utils/asyncHandler';
import { reportService } from './report.service';

export const reportController = {
  sales: asyncHandler(async (req: Request, res: Response) => {
    const userId = (req as unknown as { userId: string }).userId;
    const { period, from, to } = req.query as { period?: 'daily' | 'weekly' | 'monthly'; from?: string; to?: string };
    const data = await reportService.sales(userId, { period: period ?? 'daily', from, to });
    res.json({ success: true, data });
  }),
  expenses: asyncHandler(async (req: Request, res: Response) => {
    const userId = (req as unknown as { userId: string }).userId;
    const { from, to, groupBy } = req.query as { from?: string; to?: string; groupBy?: 'category' | 'day' };
    const data = await reportService.expenses(userId, { from, to, groupBy: groupBy ?? 'category' });
    res.json({ success: true, data });
  }),
  summary: asyncHandler(async (req: Request, res: Response) => {
    const userId = (req as unknown as { userId: string }).userId;
    const { from, to } = req.query as { from?: string; to?: string };
    const data = await reportService.summary(userId, { from, to });
    res.json({ success: true, data });
  }),
};