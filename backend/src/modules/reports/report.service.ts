import { prisma } from '../../config/prisma';

function range(from?: string, to?: string) {
  const where: { gte?: Date; lte?: Date } = {};
  if (from) where.gte = new Date(from);
  if (to) where.lte = new Date(to);
  return where;
}

function keyFor(date: Date, period: 'daily' | 'weekly' | 'monthly'): string {
  const d = new Date(date);
  if (period === 'daily') return d.toISOString().slice(0, 10);
  if (period === 'monthly') return `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, '0')}`;
  // weekly: ISO week-ish using Monday start
  const day = d.getDay() || 7;
  const monday = new Date(d);
  monday.setDate(d.getDate() - day + 1);
  return monday.toISOString().slice(0, 10);
}

export const reportService = {
  async sales(userId: string, opts: { period: 'daily' | 'weekly' | 'monthly'; from?: string; to?: string }) {
    const sales = await prisma.sale.findMany({
      where: { userId, saleDate: range(opts.from, opts.to) },
      include: { items: true },
      orderBy: { saleDate: 'asc' },
    });

    const groups = new Map<string, { revenue: number; profit: number; transactions: number; productsSold: number }>();
    for (const s of sales) {
      const k = keyFor(s.saleDate, opts.period);
      const g = groups.get(k) ?? { revenue: 0, profit: 0, transactions: 0, productsSold: 0 };
      g.revenue += s.total;
      g.profit += s.profit;
      g.transactions += 1;
      g.productsSold += s.items.reduce((a, it) => a + it.quantity, 0);
      groups.set(k, g);
    }

    const series = Array.from(groups.entries())
      .map(([period, g]) => ({ period, ...g }))
      .sort((a, b) => (a.period < b.period ? -1 : 1));

    const totals = series.reduce(
      (acc, g) => ({
        revenue: acc.revenue + g.revenue,
        profit: acc.profit + g.profit,
        transactions: acc.transactions + g.transactions,
        productsSold: acc.productsSold + g.productsSold,
      }),
      { revenue: 0, profit: 0, transactions: 0, productsSold: 0 },
    );

    return { period: opts.period, series, totals };
  },

  async expenses(userId: string, opts: { from?: string; to?: string; groupBy: 'category' | 'day' }) {
    const expenses = await prisma.expense.findMany({
      where: { userId, expenseDate: range(opts.from, opts.to) },
      orderBy: { expenseDate: 'asc' },
    });

    const groups = new Map<string, number>();
    for (const e of expenses) {
      const k = opts.groupBy === 'category' ? e.category : e.expenseDate.toISOString().slice(0, 10);
      groups.set(k, (groups.get(k) ?? 0) + e.amount);
    }

    const series = Array.from(groups.entries())
      .map(([key, amount]) => ({ key, amount }))
      .sort((a, b) => (a.key < b.key ? -1 : 1));

    const total = expenses.reduce((s, e) => s + e.amount, 0);
    return { groupBy: opts.groupBy, series, total, count: expenses.length };
  },

  async summary(userId: string, opts: { from?: string; to?: string }) {
    const sales = await prisma.sale.findMany({
      where: { userId, saleDate: range(opts.from, opts.to) },
    });
    const expenses = await prisma.expense.findMany({
      where: { userId, expenseDate: range(opts.from, opts.to) },
    });

    const revenue = sales.reduce((s, x) => s + x.total, 0);
    const profit = sales.reduce((s, x) => s + x.profit, 0);
    const totalExpenses = expenses.reduce((s, x) => s + x.amount, 0);
    return {
      revenue,
      profit,
      totalExpenses,
      net: profit - totalExpenses,
      transactions: sales.length,
    };
  },
};