import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:my_pocky/core/constants/api_constants.dart';
import 'package:my_pocky/core/storage/token_storage.dart';
import 'package:my_pocky/core/errors/exceptions.dart';

class DioClient {
  final Dio dio;
  final TokenStorage tokenStorage;

  DioClient({required this.tokenStorage})
    : dio = Dio(
        BaseOptions(
          baseUrl: ApiConstants.baseUrl,
          connectTimeout: ApiConstants.connectTimeout,
          receiveTimeout: ApiConstants.receiveTimeout,
          headers: {'Content-Type': 'application/json'},
        ),
      ) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await tokenStorage.getToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        onError: (e, handler) {
          handler.next(e);
        },
      ),
    );
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );
  }

  dynamic _handle(DioException e) {
    final data = e.response?.data;
    String msg = e.message ?? 'Network error';
    if (data is Map && data['error'] is Map) {
      msg = (data['error']['message'] ?? msg).toString();
    } else if (data is Map && data['message'] != null) {
      msg = data['message'].toString();
    }
    throw ServerException(msg, statusCode: e.response?.statusCode);
  }

  Future<Response<dynamic>> get(
    String path, {
    Map<String, dynamic>? query,
  }) async {
    try {
      return await dio.get(path, queryParameters: query);
    } on DioException catch (e) {
      throw _handle(e);
    }
  }

  Future<Response<dynamic>> post(String path, {dynamic data}) async {
    try {
      return await dio.post(path, data: data);
    } on DioException catch (e) {
      throw _handle(e);
    }
  }

  Future<Response<dynamic>> put(String path, {dynamic data}) async {
    try {
      return await dio.put(path, data: data);
    } on DioException catch (e) {
      throw _handle(e);
    }
  }

  Future<Response<dynamic>> delete(String path) async {
    try {
      return await dio.delete(path);
    } on DioException catch (e) {
      throw _handle(e);
    }
  }
}
