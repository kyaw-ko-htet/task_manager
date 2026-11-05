import { z } from 'zod';

export const registerSchema = z.object({
  body: z.object({
    email: z.string().email(),
    password: z.string().min(6),
    name: z.string().min(1),
    businessName: z.string().optional(),
  }),
});

export const loginSchema = z.object({
  body: z.object({
    email: z.string().email(),
    password: z.string().min(1),
  }),
});

export const updateProfileSchema = z.object({
  body: z.object({
    name: z.string().min(1).optional(),
    businessName: z.string().optional(),
    phone: z.string().optional(),
    address: z.string().optional(),
    currency: z.string().optional(),
    password: z.string().min(6).optional(),
  }),
});