import { productRepository } from './product.repository';
import { NotFoundError, ConflictError } from '../../shared/errors/AppError';

export const productService = {
  async list(userId: string, opts: { search?: string; page: number; limit: number }) {
    const [items, total] = await Promise.all([
      productRepository.findAll(userId, opts),
      productRepository.count(userId, opts.search),
    ]);
    return { items, total, page: opts.page, limit: opts.limit };
  },

  async getById(userId: string, id: string) {
    const product = await productRepository.findById(userId, id);
    if (!product) throw new NotFoundError('Product not found');
    return product;
  },

  async create(userId: string, data: { name: string; sku: string; costPrice: number; sellingPrice: number; stockQuantity: number }) {
    try {
      return await productRepository.create(userId, data);
    } catch (e: unknown) {
      if (isUniqueConstraintError(e)) throw new ConflictError('SKU already exists');
      throw e;
    }
  },

  async update(userId: string, id: string, data: Record<string, unknown>) {
    const existing = await productRepository.findById(userId, id);
    if (!existing) throw new NotFoundError('Product not found');
    try {
      await productRepository.update(userId, id, data);
    } catch (e: unknown) {
      if (isUniqueConstraintError(e)) throw new ConflictError('SKU already exists');
      throw e;
    }
    return productRepository.findById(userId, id);
  },

  async delete(userId: string, id: string) {
    const existing = await productRepository.findById(userId, id);
    if (!existing) throw new NotFoundError('Product not found');
    await productRepository.delete(userId, id);
  },
};

function isUniqueConstraintError(e: unknown): boolean {
  return typeof e === 'object' && e !== null && (e as { code?: string }).code === 'P2002';
}