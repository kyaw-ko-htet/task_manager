import { prisma } from '../../config/prisma';
import { saleRepository } from './sale.repository';
import { NotFoundError, ValidationError } from '../../shared/errors/AppError';
import { calculateSale } from './sale.calculator';

interface SaleItemInput { productId: string; quantity: number; }

export const saleService = {
  async list(userId: string, opts: { from?: string; to?: string; page: number; limit: number }) {
    const [items, total] = await Promise.all([
      saleRepository.findAll(userId, opts),
      saleRepository.count(userId, opts),
    ]);
    return { items, total, page: opts.page, limit: opts.limit };
  },

  async getById(userId: string, id: string) {
    const sale = await saleRepository.findById(userId, id);
    if (!sale) throw new NotFoundError('Sale not found');
    return sale;
  },

  async create(
    userId: string,
    input: {
      items: SaleItemInput[];
      discountType: 'NONE' | 'PERCENT' | 'FIXED';
      discountValue: number;
      notes?: string;
      saleDate?: string;
    },
  ) {
    return prisma.$transaction(async (tx) => {
      const productIds = input.items.map((i) => i.productId);
      const products = await tx.product.findMany({
        where: { id: { in: productIds }, userId },
      });
      const productMap = new Map(products.map((p) => [p.id, p]));

      for (const item of input.items) {
        const p = productMap.get(item.productId);
        if (!p) throw new NotFoundError(`Product not found: ${item.productId}`);
        if (p.stockQuantity < item.quantity) {
          throw new ValidationError(`Insufficient stock for ${p.name}`);
        }
      }

      const calcInput = input.items.map((item) => {
        const p = productMap.get(item.productId)!;
        return { quantity: item.quantity, costPrice: p.costPrice, sellingPrice: p.sellingPrice };
      });
      const calc = calculateSale(calcInput, input.discountType, input.discountValue);

      const lineItems = input.items.map((item, idx) => {
        const p = productMap.get(item.productId)!;
        return {
          productId: p.id,
          productName: p.name,
          sku: p.sku,
          quantity: item.quantity,
          costPrice: p.costPrice,
          sellingPrice: p.sellingPrice,
          lineTotal: calc.lines[idx].lineTotal,
          lineProfit: calc.lines[idx].lineProfit,
        };
      });

      for (const item of input.items) {
        await tx.product.update({
          where: { id: item.productId },
          data: { stockQuantity: { decrement: item.quantity } },
        });
      }

      const sale = await tx.sale.create({
        data: {
          userId,
          saleDate: input.saleDate ? new Date(input.saleDate) : new Date(),
          discountType: input.discountType,
          discountValue: input.discountValue,
          subtotal: calc.subtotal,
          discountAmount: calc.discountAmount,
          total: calc.total,
          profit: calc.profit,
          notes: input.notes,
          items: { create: lineItems },
        },
        include: { items: true },
      });

      return sale;
    });
  },
};