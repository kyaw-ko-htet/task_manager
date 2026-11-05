import express from 'express';
import cors from 'cors';
import helmet from 'helmet';
import morgan from 'morgan';
import { env } from './config/env';
import { errorMiddleware } from './middlewares/error.middleware';

import authRoutes from './modules/auth/auth.routes';
import productRoutes from './modules/products/product.routes';
import saleRoutes from './modules/sales/sale.routes';
import expenseRoutes from './modules/expenses/expense.routes';
import dashboardRoutes from './modules/dashboard/dashboard.routes';
import reportRoutes from './modules/reports/report.routes';

const app = express();

app.use(helmet());
app.use(cors({ origin: env.CORS_ORIGIN === '*' ? '*' : env.CORS_ORIGIN.split(',') }));
app.use(morgan('dev'));
app.use(express.json());

app.get('/health', (_req, res) => {
  res.json({ success: true, message: 'OK' });
});

app.use('/api/v1/auth', authRoutes);
app.use('/api/v1/products', productRoutes);
app.use('/api/v1/sales', saleRoutes);
app.use('/api/v1/expenses', expenseRoutes);
app.use('/api/v1/dashboard', dashboardRoutes);
app.use('/api/v1/reports', reportRoutes);

app.use((_req, res) => {
  res.status(404).json({ success: false, error: { code: 'NOT_FOUND', message: 'Route not found' } });
});

app.use(errorMiddleware);

export default app;