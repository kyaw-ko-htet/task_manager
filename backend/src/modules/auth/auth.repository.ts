import { prisma } from '../../config/prisma';

export const authRepository = {
  findByEmail(email: string) {
    return prisma.user.findUnique({ where: { email } });
  },
  findById(id: string) {
    return prisma.user.findUnique({ where: { id } });
  },
  create(data: { email: string; passwordHash: string; name: string; businessName?: string }) {
    return prisma.user.create({ data });
  },
  update(id: string, data: Record<string, unknown>) {
    return prisma.user.update({ where: { id }, data });
  },
};