import { prisma } from '../../config/prisma';

export const dashboardService = {
  async summary(userId: string, dateStr?: string) {
    const base = dateStr ? new Date(dateStr) : new Date();
    const start = new Date(base);
    start.setUTCHours(0, 0, 0, 0);
    const end = new Date(base);
    end.setUTCHours(23, 59, 59, 999);

    const sales = await prisma.sale.findMany({
      where: { userId, saleDate: { gte: start, lte: end } },
      include: { items: true },
      orderBy: { saleDate: 'desc' },
    });

    const totalSales = sales.reduce((s, sale) => s + sale.total, 0);
    const totalProfit = sales.reduce((s, sale) => s + sale.profit, 0);
    const totalTransactions = sales.length;
    const totalProductsSold = sales.reduce(
      (s, sale) => s + sale.items.reduce((a, it) => a + it.quantity, 0),
      0,
    );

    const recentSales = sales.slice(0, 5).map((s) => ({
      id: s.id,
      saleDate: s.saleDate,
      total: s.total,
      profit: s.profit,
      itemCount: s.items.length,
    }));

    // 7-day trend
    const trendStart = new Date(start);
    trendStart.setDate(trendStart.getDate() - 6);
    const trendSales = await prisma.sale.findMany({
      where: { userId, saleDate: { gte: trendStart, lte: end } },
      select: { saleDate: true, total: true },
    });
    const trendMap = new Map<string, number>();
    for (let i = 0; i < 7; i++) {
      const d = new Date(trendStart);
      d.setDate(d.getDate() + i);
      trendMap.set(d.toISOString().slice(0, 10), 0);
    }
    for (const s of trendSales) {
      const key = s.saleDate.toISOString().slice(0, 10);
      if (trendMap.has(key)) trendMap.set(key, (trendMap.get(key) ?? 0) + s.total);
    }
    const trend = Array.from(trendMap.entries()).map(([date, total]) => ({ date, total }));

    return {
      date: start.toISOString().slice(0, 10),
      totalSales,
      totalProfit,
      totalTransactions,
      totalProductsSold,
      recentSales,
      trend,
    };
  },
};