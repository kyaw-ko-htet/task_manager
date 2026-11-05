import { z } from 'zod';

export const dashboardSchema = z.object({
  query: z.object({
    date: z.string().optional(),
  }),
});