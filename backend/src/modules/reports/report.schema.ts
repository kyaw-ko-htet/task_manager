import { z } from 'zod';

export const salesReportSchema = z.object({
  query: z.object({
    period: z.enum(['daily', 'weekly', 'monthly']).default('daily'),
    from: z.string().optional(),
    to: z.string().optional(),
  }),
});

export const expensesReportSchema = z.object({
  query: z.object({
    from: z.string().optional(),
    to: z.string().optional(),
    groupBy: z.enum(['category', 'day']).default('category'),
  }),
});

export const summaryReportSchema = z.object({
  query: z.object({
    from: z.string().optional(),
    to: z.string().optional(),
  }),
});