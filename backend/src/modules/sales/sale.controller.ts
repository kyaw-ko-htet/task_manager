import { Request, Response } from 'express';
import { asyncHandler } from '../../shared/utils/asyncHandler';
import { saleService } from './sale.service';

export const saleController = {
  list: asyncHandler(async (req: Request, res: Response) => {
    const userId = (req as unknown as { userId: string }).userId;
    const { from, to, page, limit } = req.query as { from?: string; to?: string; page?: string; limit?: string };
    const result = await saleService.list(userId, {
      from,
      to,
      page: Number(page) || 1,
      limit: Number(limit) || 20,
    });
    res.json({ success: true, data: result });
  }),

  getById: asyncHandler(async (req: Request, res: Response) => {
    const userId = (req as unknown as { userId: string }).userId;
    const sale = await saleService.getById(userId, req.params.id as string);
    res.json({ success: true, data: sale });
  }),

  create: asyncHandler(async (req: Request, res: Response) => {
    const userId = (req as unknown as { userId: string }).userId;
    const sale = await saleService.create(userId, req.body);
    res.status(201).json({ success: true, data: sale });
  }),
};