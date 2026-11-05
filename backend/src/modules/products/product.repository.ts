import { prisma } from '../../config/prisma';

export const productRepository = {
  findAll(userId: string, opts: { search?: string; page: number; limit: number }) {
    const where: { userId: string; name?: { contains: string } } = { userId };
    if (opts.search) where.name = { contains: opts.search };
    return prisma.product.findMany({
      where,
      orderBy: { createdAt: 'desc' },
      skip: (opts.page - 1) * opts.limit,
      take: opts.limit,
    });
  },
  count(userId: string, search?: string) {
    const where: { userId: string; name?: { contains: string } } = { userId };
    if (search) where.name = { contains: search };
    return prisma.product.count({ where });
  },
  findById(userId: string, id: string) {
    return prisma.product.findFirst({ where: { id, userId } });
  },
  create(userId: string, data: {
    name: string; sku: string; costPrice: number; sellingPrice: number; stockQuantity: number;
  }) {
    return prisma.product.create({ data: { userId, ...data } });
  },
  update(userId: string, id: string, data: Record<string, unknown>) {
    return prisma.product.updateMany({ where: { id, userId }, data });
  },
  delete(userId: string, id: string) {
    return prisma.product.deleteMany({ where: { id, userId } });
  },
};