import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DioConfig {
  static Dio createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://techtest.youapp.ai/api',
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 3),
        headers: {
          'accept': '*/*',
        },
      ),
    );

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        const storage = FlutterSecureStorage();
        final token = await storage.read(key: 'auth_token');
        print('Token retrieved for request: $token');
        if (token != null) {
          options.headers['x-access-token'] = token;
          print('x-access-token header set: ${options.headers['x-access-token']}');
        } else {
          print('No token found in storage');
        }
        return handler.next(options);
      },
      onError: (DioException e, handler) {
        print('Dio Error: ${e.response?.data}');
        return handler.next(e);
      },
    ));

    return dio;
  }
}