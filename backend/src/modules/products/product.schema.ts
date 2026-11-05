import { z } from 'zod';

export const createProductSchema = z.object({
  body: z.object({
    name: z.string().min(1),
    sku: z.string().min(1),
    costPrice: z.coerce.number().nonnegative(),
    sellingPrice: z.coerce.number().nonnegative(),
    stockQuantity: z.coerce.number().int().nonnegative().default(0),
  }),
});

export const updateProductSchema = z.object({
  body: z.object({
    name: z.string().min(1).optional(),
    sku: z.string().min(1).optional(),
    costPrice: z.coerce.number().nonnegative().optional(),
    sellingPrice: z.coerce.number().nonnegative().optional(),
    stockQuantity: z.coerce.number().int().nonnegative().optional(),
  }),
  params: z.object({ id: z.string().min(1) }),
});

export const productIdSchema = z.object({
  params: z.object({ id: z.string().min(1) }),
});

export const listProductSchema = z.object({
  query: z.object({
    search: z.string().optional(),
    page: z.coerce.number().int().positive().default(1),
    limit: z.coerce.number().int().positive().max(100).default(20),
  }),
});