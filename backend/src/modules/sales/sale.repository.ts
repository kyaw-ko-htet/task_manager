import { prisma } from '../../config/prisma';

export const saleRepository = {
  findAll(userId: string, opts: { from?: string; to?: string; page: number; limit: number }) {
    const where: { userId: string; saleDate?: { gte?: Date; lte?: Date } } = { userId };
    if (opts.from || opts.to) {
      where.saleDate = {};
      if (opts.from) where.saleDate.gte = new Date(opts.from);
      if (opts.to) where.saleDate.lte = new Date(opts.to);
    }
    return prisma.sale.findMany({
      where,
      include: { items: true },
      orderBy: { saleDate: 'desc' },
      skip: (opts.page - 1) * opts.limit,
      take: opts.limit,
    });
  },
  count(userId: string, opts: { from?: string; to?: string }) {
    const where: { userId: string; saleDate?: { gte?: Date; lte?: Date } } = { userId };
    if (opts.from || opts.to) {
      where.saleDate = {};
      if (opts.from) where.saleDate.gte = new Date(opts.from);
      if (opts.to) where.saleDate.lte = new Date(opts.to);
    }
    return prisma.sale.count({ where });
  },
  findById(userId: string, id: string) {
    return prisma.sale.findFirst({ where: { id, userId }, include: { items: true } });
  },
  create(data: {
    userId: string;
    saleDate?: Date;
    discountType: string;
    discountValue: number;
    subtotal: number;
    discountAmount: number;
    total: number;
    profit: number;
    notes?: string;
    items: Array<{
      productId: string | null;
      productName: string;
      sku: string | null;
      quantity: number;
      costPrice: number;
      sellingPrice: number;
      lineTotal: number;
      lineProfit: number;
    }>;
  }) {
    return prisma.sale.create({
      data: {
        userId: data.userId,
        saleDate: data.saleDate,
        discountType: data.discountType,
        discountValue: data.discountValue,
        subtotal: data.subtotal,
        discountAmount: data.discountAmount,
        total: data.total,
        profit: data.profit,
        notes: data.notes,
        items: { create: data.items },
      },
      include: { items: true },
    });
  },
};