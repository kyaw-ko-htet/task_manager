import { Router } from 'express';
import { reportController } from './report.controller';
import { validate } from '../../middlewares/validate.middleware';
import { authMiddleware } from '../../middlewares/auth.middleware';
import { salesReportSchema, expensesReportSchema, summaryReportSchema } from './report.schema';

const router = Router();
router.use(authMiddleware);

router.get('/sales', validate(salesReportSchema), reportController.sales);
router.get('/expenses', validate(expensesReportSchema), reportController.expenses);
router.get('/summary', validate(summaryReportSchema), reportController.summary);

export default router;