import { Router } from 'express';
import { dashboardController } from './dashboard.controller';
import { validate } from '../../middlewares/validate.middleware';
import { authMiddleware } from '../../middlewares/auth.middleware';
import { dashboardSchema } from './dashboard.schema';

const router = Router();
router.use(authMiddleware);
router.get('/summary', validate(dashboardSchema), dashboardController.summary);

export default router;