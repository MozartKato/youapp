import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../domain/entities/profile.dart';
import '../../../../core/network/dio_config.dart';

class ProfileRepository {
  final Dio _dio = DioConfig.createDio();
  final _storage = const FlutterSecureStorage();

  Future<Either<String, Profile>> getProfile() async {
    try {
      final token = await _storage.read(key: 'auth_token');
      if (token == null) return const Left('No token found');

      final response = await _dio.get(
        '/getProfile',
        options: Options(
          headers: {'x-access-token': token},
        ),
      );
      return Right(Profile.fromJson(response.data));
    } catch (e) {
      return Left('Failed to get profile: ${e.toString()}');
    }
  }

  Future<Either<String, Profile>> createProfile({
    required String name,
    String birthday = '',
    int height = 0,
    int weight = 0,
    List<String> interests = const [],
  }) async {
    try {
      final token = await _storage.read(key: 'auth_token');
      if (token == null) return const Left('No token found');

      final response = await _dio.post(
        '/createProfile',
        data: {
          'name': name,
          'birthday': birthday,
          'height': height,
          'weight': weight,
          'interests': interests,
        },
        options: Options(
          headers: {'x-access-token': token},
        ),
      );
      print('Create Profile Response: ${response.data}');
      return Right(Profile.fromJson(response.data));
    } catch (e) {
      print('Create Profile Error: $e');
      return Left('Failed to create profile: ${e.toString()}');
    }
  }

  Future<Either<String, Profile>> updateProfile(Profile profile) async {
    try {
      final token = await _storage.read(key: 'auth_token');
      if (token == null) return const Left('No token found');

      final response = await _dio.put(
        '/updateProfile',
        data: profile.toJson(),
        options: Options(
          headers: {'x-access-token': token},
        ),
      );
      return Right(Profile.fromJson(response.data));
    } catch (e) {
      return Left('Failed to update profile: ${e.toString()}');
    }
  }
}