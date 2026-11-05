import { Router } from 'express';
import { authController } from './auth.controller';
import { validate } from '../../middlewares/validate.middleware';
import { authMiddleware } from '../../middlewares/auth.middleware';
import { registerSchema, loginSchema, updateProfileSchema } from './auth.schema';

const router = Router();

router.post('/register', validate(registerSchema), authController.register);
router.post('/login', validate(loginSchema), authController.login);
router.get('/me', authMiddleware, authController.me);
router.put('/profile', authMiddleware, validate(updateProfileSchema), authController.updateProfile);

export default router;