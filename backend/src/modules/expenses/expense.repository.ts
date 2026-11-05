import { prisma } from '../../config/prisma';

export const expenseRepository = {
  findAll(userId: string, opts: { from?: string; to?: string; category?: string; page: number; limit: number }) {
    const where: { userId: string; category?: string; expenseDate?: { gte?: Date; lte?: Date } } = { userId };
    if (opts.category) where.category = opts.category;
    if (opts.from || opts.to) {
      where.expenseDate = {};
      if (opts.from) where.expenseDate.gte = new Date(opts.from);
      if (opts.to) where.expenseDate.lte = new Date(opts.to);
    }
    return prisma.expense.findMany({
      where,
      orderBy: { expenseDate: 'desc' },
      skip: (opts.page - 1) * opts.limit,
      take: opts.limit,
    });
  },
  count(userId: string, opts: { from?: string; to?: string; category?: string }) {
    const where: { userId: string; category?: string; expenseDate?: { gte?: Date; lte?: Date } } = { userId };
    if (opts.category) where.category = opts.category;
    if (opts.from || opts.to) {
      where.expenseDate = {};
      if (opts.from) where.expenseDate.gte = new Date(opts.from);
      if (opts.to) where.expenseDate.lte = new Date(opts.to);
    }
    return prisma.expense.count({ where });
  },
  findById(userId: string, id: string) {
    return prisma.expense.findFirst({ where: { id, userId } });
  },
  create(userId: string, data: { title: string; amount: number; category: string; expenseDate?: Date; notes?: string }) {
    return prisma.expense.create({ data: { userId, ...data } });
  },
  update(userId: string, id: string, data: Record<string, unknown>) {
    return prisma.expense.updateMany({ where: { id, userId }, data });
  },
  delete(userId: string, id: string) {
    return prisma.expense.deleteMany({ where: { id, userId } });
  },
};