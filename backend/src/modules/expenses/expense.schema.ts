import { z } from 'zod';

export const createExpenseSchema = z.object({
  body: z.object({
    title: z.string().min(1),
    amount: z.coerce.number().nonnegative(),
    category: z.string().min(1),
    expenseDate: z.string().datetime().optional(),
    notes: z.string().optional(),
  }),
});

export const updateExpenseSchema = z.object({
  body: z.object({
    title: z.string().min(1).optional(),
    amount: z.coerce.number().nonnegative().optional(),
    category: z.string().min(1).optional(),
    expenseDate: z.string().datetime().optional(),
    notes: z.string().optional(),
  }),
  params: z.object({ id: z.string().min(1) }),
});

export const expenseIdSchema = z.object({
  params: z.object({ id: z.string().min(1) }),
});

export const listExpenseSchema = z.object({
  query: z.object({
    from: z.string().optional(),
    to: z.string().optional(),
    category: z.string().optional(),
    page: z.coerce.number().int().positive().default(1),
    limit: z.coerce.number().int().positive().max(100).default(20),
  }),
});