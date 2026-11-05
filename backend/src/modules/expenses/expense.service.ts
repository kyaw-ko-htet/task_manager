import { expenseRepository } from './expense.repository';
import { NotFoundError } from '../../shared/errors/AppError';

export const expenseService = {
  async list(userId: string, opts: { from?: string; to?: string; category?: string; page: number; limit: number }) {
    const [items, total] = await Promise.all([
      expenseRepository.findAll(userId, opts),
      expenseRepository.count(userId, opts),
    ]);
    return { items, total, page: opts.page, limit: opts.limit };
  },
  async getById(userId: string, id: string) {
    const e = await expenseRepository.findById(userId, id);
    if (!e) throw new NotFoundError('Expense not found');
    return e;
  },
  async create(userId: string, data: { title: string; amount: number; category: string; expenseDate?: string; notes?: string }) {
    return expenseRepository.create(userId, {
      title: data.title,
      amount: data.amount,
      category: data.category,
      expenseDate: data.expenseDate ? new Date(data.expenseDate) : undefined,
      notes: data.notes,
    });
  },
  async update(userId: string, id: string, data: Record<string, unknown>) {
    const existing = await expenseRepository.findById(userId, id);
    if (!existing) throw new NotFoundError('Expense not found');
    const updateData: Record<string, unknown> = { ...data };
    if (typeof data.expenseDate === 'string') updateData.expenseDate = new Date(data.expenseDate as string);
    await expenseRepository.update(userId, id, updateData);
    return expenseRepository.findById(userId, id);
  },
  async delete(userId: string, id: string) {
    const existing = await expenseRepository.findById(userId, id);
    if (!existing) throw new NotFoundError('Expense not found');
    await expenseRepository.delete(userId, id);
  },
};