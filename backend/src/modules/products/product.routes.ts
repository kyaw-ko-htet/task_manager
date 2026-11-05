import { Router } from 'express';
import { productController } from './product.controller';
import { validate } from '../../middlewares/validate.middleware';
import { authMiddleware } from '../../middlewares/auth.middleware';
import {
  createProductSchema,
  updateProductSchema,
  productIdSchema,
  listProductSchema,
} from './product.schema';

const router = Router();
router.use(authMiddleware);

router.get('/', validate(listProductSchema), productController.list);
router.get('/:id', validate(productIdSchema), productController.getById);
router.post('/', validate(createProductSchema), productController.create);
router.put('/:id', validate(updateProductSchema), productController.update);
router.delete('/:id', validate(productIdSchema), productController.delete);

export default router;