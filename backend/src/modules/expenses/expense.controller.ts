import { Request, Response } from 'express';
import { asyncHandler } from '../../shared/utils/asyncHandler';
import { expenseService } from './expense.service';

export const expenseController = {
  list: asyncHandler(async (req: Request, res: Response) => {
    const userId = (req as unknown as { userId: string }).userId;
    const { from, to, category, page, limit } = req.query as { from?: string; to?: string; category?: string; page?: string; limit?: string };
    const result = await expenseService.list(userId, {
      from, to, category,
      page: Number(page) || 1,
      limit: Number(limit) || 20,
    });
    res.json({ success: true, data: result });
  }),
  getById: asyncHandler(async (req: Request, res: Response) => {
    const userId = (req as unknown as { userId: string }).userId;
    const e = await expenseService.getById(userId, req.params.id as string);
    res.json({ success: true, data: e });
  }),
  create: asyncHandler(async (req: Request, res: Response) => {
    const userId = (req as unknown as { userId: string }).userId;
    const e = await expenseService.create(userId, req.body);
    res.status(201).json({ success: true, data: e });
  }),
  update: asyncHandler(async (req: Request, res: Response) => {
    const userId = (req as unknown as { userId: string }).userId;
    const e = await expenseService.update(userId, req.params.id as string, req.body);
    res.json({ success: true, data: e });
  }),
  delete: asyncHandler(async (req: Request, res: Response) => {
    const userId = (req as unknown as { userId: string }).userId;
    await expenseService.delete(userId, req.params.id as string);
    res.status(204).send();
  }),
};