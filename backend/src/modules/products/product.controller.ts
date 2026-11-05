import { Request, Response } from 'express';
import { asyncHandler } from '../../shared/utils/asyncHandler';
import { productService } from './product.service';

export const productController = {
  list: asyncHandler(async (req: Request, res: Response) => {
    const userId = (req as unknown as { userId: string }).userId;
    const { search, page, limit } = req.query as { search?: string; page?: string; limit?: string };
    const result = await productService.list(userId, {
      search,
      page: Number(page) || 1,
      limit: Number(limit) || 20,
    });
    res.json({ success: true, data: result });
  }),

  getById: asyncHandler(async (req: Request, res: Response) => {
    const userId = (req as unknown as { userId: string }).userId;
    const product = await productService.getById(userId, req.params.id as string);
    res.json({ success: true, data: product });
  }),

  create: asyncHandler(async (req: Request, res: Response) => {
    const userId = (req as unknown as { userId: string }).userId;
    const product = await productService.create(userId, req.body);
    res.status(201).json({ success: true, data: product });
  }),

  update: asyncHandler(async (req: Request, res: Response) => {
    const userId = (req as unknown as { userId: string }).userId;
    const product = await productService.update(userId, req.params.id as string, req.body);
    res.json({ success: true, data: product });
  }),

  delete: asyncHandler(async (req: Request, res: Response) => {
    const userId = (req as unknown as { userId: string }).userId;
    await productService.delete(userId, req.params.id as string);
    res.status(204).send();
  }),
};