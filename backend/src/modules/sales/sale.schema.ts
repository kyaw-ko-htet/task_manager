import { z } from 'zod';

export const createSaleSchema = z.object({
  body: z.object({
    items: z.array(
      z.object({
        productId: z.string().min(1),
        quantity: z.coerce.number().int().positive(),
      }),
    ).min(1),
    discountType: z.enum(['NONE', 'PERCENT', 'FIXED']).default('NONE'),
    discountValue: z.coerce.number().nonnegative().default(0),
    notes: z.string().optional(),
    saleDate: z.string().datetime().optional(),
  }),
});

export const saleIdSchema = z.object({
  params: z.object({ id: z.string().min(1) }),
});

export const listSaleSchema = z.object({
  query: z.object({
    from: z.string().optional(),
    to: z.string().optional(),
    page: z.coerce.number().int().positive().default(1),
    limit: z.coerce.number().int().positive().max(100).default(20),
  }),
});