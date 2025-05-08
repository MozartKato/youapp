import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../data/models/login_model.dart';
import '../../data/models/register_model.dart';
import '../../../../core/network/dio_config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthRepository {
  final Dio _dio = DioConfig.createDio();
  final _storage = const FlutterSecureStorage();

  Future<Either<String, LoginModel>> login(String email, String username, String password) async {
    try {
      final response = await _dio.post('/login', data: {
        'email': email,
        'username': username,
        'password': password,
      });
      final model = LoginModel.fromJson(response.data);
      print('Login Token: ${model.accessToken}');
      try {
        await _storage.write(key: 'auth_token', value: model.accessToken);
        final storedToken = await _storage.read(key: 'auth_token');
        print('Stored Token after Login: $storedToken');
        if (storedToken == null) {
          return const Left('Failed to store token');
        }
      } catch (e) {
        print('Storage Error during Login: $e');
        return Left('Failed to store token: ${e.toString()}');
      }
      return Right(model);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return const Left('Invalid email, username, or password');
      } else if (e.response?.statusCode == 500) {
        return const Left('Server error, please try again later');
      }
      return Left('Login failed: ${e.message}');
    } catch (e) {
      return Left('Unexpected error: ${e.toString()}');
    }
  }

  Future<Either<String, RegisterModel>> register(
      String email, String username, String password) async {
    try {
      final response = await _dio.post('/register', data: {
        'email': email,
        'username': username,
        'password': password,
      });
      final model = RegisterModel.fromJson(response.data);
      print('Register Token: ${model.accessToken}');
      try {
        await _storage.write(key: 'auth_token', value: model.accessToken);
        final storedToken = await _storage.read(key: 'auth_token');
        print('Stored Token after Register: $storedToken');
        if (storedToken == null) {
          return const Left('Failed to store token');
        }
      } catch (e) {
        print('Storage Error during Register: $e');
        return Left('Failed to store token: ${e.toString()}');
      }
      return Right(model);
    } catch (e) {
      return Left('Register failed: ${e.toString()}');
    }
  }

  Future<Either<String, bool>> logout() async {
    try {
      await _storage.delete(key: 'auth_token');
      print('Token deleted on logout');
      return const Right(true);
    } catch (e) {
      return Left('Logout failed: ${e.toString()}');
    }
  }

  // Method untuk memeriksa token tersimpan
  Future<String?> getStoredToken() async {
    try {
      final token = await _storage.read(key: 'auth_token');
      print('Retrieved Stored Token: $token');
      return token;
    } catch (e) {
      print('Error retrieving token: $e');
      return null;
    }
  }
}