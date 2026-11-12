import 'package:dio/dio.dart';
import 'package:my_pocky/core/network/dio_client.dart';
import 'package:my_pocky/core/network/api_endpoints.dart';
import 'package:my_pocky/core/storage/token_storage.dart';
import 'package:my_pocky/core/errors/exceptions.dart';
import 'package:my_pocky/features/auth/domain/repositories/auth_repository.dart';
import 'package:my_pocky/features/auth/domain/entities/user.dart';
import 'package:my_pocky/features/auth/data/models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final DioClient dioClient;
  final TokenStorage tokenStorage;

  AuthRepositoryImpl({required this.dioClient, required this.tokenStorage});

  @override
  Future<String> register({
    required String email,
    required String password,
    required String name,
    String? businessName,
  }) async {
    try {
      final res = await dioClient.post(ApiEndpoints.authRegister, data: {
        'email': email,
        'password': password,
        'name': name,
        'businessName': businessName,
      });
      final token = res.data['data']['accessToken'] as String;
      await tokenStorage.saveToken(token);
      return token;
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Register failed');
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> login({required String email, required String password}) async {
    try {
      final res = await dioClient.post(ApiEndpoints.authLogin, data: {
        'email': email,
        'password': password,
      });
      final token = res.data['data']['accessToken'] as String;
      await tokenStorage.saveToken(token);
      return token;
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(e.toString());
    }
  }

  @override
  Future<User> getProfile() async {
    final res = await dioClient.get(ApiEndpoints.authMe);
    return UserModel.fromJson(res.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<User> updateProfile(Map<String, dynamic> data) async {
    final res = await dioClient.put(ApiEndpoints.authProfile, data: data);
    return UserModel.fromJson(res.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<void> logout() async {
    await tokenStorage.clear();
  }
}
