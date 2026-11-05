import { calculateSale } from '../src/modules/sales/sale.calculator';

describe('calculateSale', () => {
  it('computes subtotal/total/profit without discount', () => {
    const r = calculateSale(
      [{ quantity: 3, costPrice: 5, sellingPrice: 10 }],
      'NONE',
      0,
    );
    expect(r.subtotal).toBe(30);
    expect(r.discountAmount).toBe(0);
    expect(r.total).toBe(30);
    expect(r.profit).toBe(15);
  });

  it('applies percent discount', () => {
    const r = calculateSale(
      [{ quantity: 3, costPrice: 5, sellingPrice: 10 }],
      'PERCENT',
      10,
    );
    expect(r.subtotal).toBe(30);
    expect(r.discountAmount).toBe(3);
    expect(r.total).toBe(27);
    expect(r.profit).toBe(12);
  });

  it('applies fixed discount and caps at subtotal', () => {
    const r = calculateSale(
      [{ quantity: 2, costPrice: 4, sellingPrice: 10 }],
      'FIXED',
      100,
    );
    expect(r.subtotal).toBe(20);
    expect(r.discountAmount).toBe(20);
    expect(r.total).toBe(0);
    expect(r.profit).toBe(12 - 20); // lineProfit 12 - discount 20
  });

  it('handles multiple items', () => {
    const r = calculateSale(
      [
        { quantity: 1, costPrice: 2, sellingPrice: 5 },
        { quantity: 2, costPrice: 3, sellingPrice: 6 },
      ],
      'NONE',
      0,
    );
    expect(r.subtotal).toBe(5 + 12);
    expect(r.profit).toBe(3 + 6);
    expect(r.lines).toHaveLength(2);
  });
});