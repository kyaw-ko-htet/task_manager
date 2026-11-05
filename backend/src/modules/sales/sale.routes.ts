import { Router } from 'express';
import { saleController } from './sale.controller';
import { validate } from '../../middlewares/validate.middleware';
import { authMiddleware } from '../../middlewares/auth.middleware';
import { createSaleSchema, saleIdSchema, listSaleSchema } from './sale.schema';

const router = Router();
router.use(authMiddleware);

router.get('/', validate(listSaleSchema), saleController.list);
router.get('/:id', validate(saleIdSchema), saleController.getById);
router.post('/', validate(createSaleSchema), saleController.create);

export default router;