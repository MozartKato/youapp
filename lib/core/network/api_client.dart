import 'package:dio/dio.dart';
import 'dio_config.dart';

class ApiClient {
  static final Dio dio = DioConfig.createDio();
}