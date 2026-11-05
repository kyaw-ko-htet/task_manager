export interface SaleLineInput {
  quantity: number;
  costPrice: number;
  sellingPrice: number;
}

export interface SaleLineResult {
  lineTotal: number;
  lineProfit: number;
}

export interface SaleCalculation {
  subtotal: number;
  discountAmount: number;
  total: number;
  profit: number;
  lines: SaleLineResult[];
}

export function calculateLines(items: SaleLineInput[]): SaleLineResult[] {
  return items.map((it) => ({
    lineTotal: it.quantity * it.sellingPrice,
    lineProfit: it.quantity * (it.sellingPrice - it.costPrice),
  }));
}

export function calculateDiscount(subtotal: number, discountType: 'NONE' | 'PERCENT' | 'FIXED', discountValue: number): number {
  let amount = 0;
  if (discountType === 'PERCENT') amount = subtotal * (discountValue / 100);
  else if (discountType === 'FIXED') amount = discountValue;
  if (amount > subtotal) amount = subtotal;
  if (amount < 0) amount = 0;
  return amount;
}

export function calculateSale(
  items: SaleLineInput[],
  discountType: 'NONE' | 'PERCENT' | 'FIXED',
  discountValue: number,
): SaleCalculation {
  const lines = calculateLines(items);
  const subtotal = lines.reduce((s, l) => s + l.lineTotal, 0);
  const discountAmount = calculateDiscount(subtotal, discountType, discountValue);
  const total = subtotal - discountAmount;
  const totalLineProfit = lines.reduce((s, l) => s + l.lineProfit, 0);
  const profit = totalLineProfit - discountAmount;
  return { subtotal, discountAmount, total, profit, lines };
}