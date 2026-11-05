import 'package:mobile/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<String> register({
    required String email,
    required String password,
    required String name,
    String? businessName,
  });

  Future<String> login({required String email, required String password});

  Future<User> getProfile();

  Future<User> updateProfile(Map<String, dynamic> data);

  Future<void> logout();
}
