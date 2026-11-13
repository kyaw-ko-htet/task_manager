class ApiConstants {
  ApiConstants._();

  // For Android emulator use 10.0.2.2; for iOS simulator use localhost.
  static const String baseUrl = 'http://192.168.2.35:3000/api/v1';
  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);
}
