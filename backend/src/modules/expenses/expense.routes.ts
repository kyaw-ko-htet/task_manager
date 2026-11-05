import { Router } from 'express';
import { expenseController } from './expense.controller';
import { validate } from '../../middlewares/validate.middleware';
import { authMiddleware } from '../../middlewares/auth.middleware';
import { createExpenseSchema, updateExpenseSchema, expenseIdSchema, listExpenseSchema } from './expense.schema';

const router = Router();
router.use(authMiddleware);

router.get('/', validate(listExpenseSchema), expenseController.list);
router.get('/:id', validate(expenseIdSchema), expenseController.getById);
router.post('/', validate(createExpenseSchema), expenseController.create);
router.put('/:id', validate(updateExpenseSchema), expenseController.update);
router.delete('/:id', validate(expenseIdSchema), expenseController.delete);

export default router;