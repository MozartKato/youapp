import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../data/models/profile_model.dart';
import '../../../../core/network/dio_config.dart';

class ProfileRepository {
  final Dio _dio = DioConfig.createDio();

  Future<Either<String, ProfileModel>> getProfile() async {
    try {
      final response = await _dio.get('/getProfile');
      final profile = ProfileModel.fromJson(response.data);
      return Right(profile);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return const Left('Unauthorized: Invalid or missing token');
      } else if (e.response?.statusCode == 500) {
        return const Left('Server error, please try again later');
      }
      return Left('Failed to fetch profile: ${e.message}');
    } catch (e) {
      return Left('Unexpected error: ${e.toString()}');
    }
  }

  Future<Either<String, ProfileModel>> createProfile(ProfileModel profile) async {
    try {
      final response = await _dio.post('/createProfile', data: profile.toJson());
      final newProfile = ProfileModel.fromJson(response.data);
      return Right(newProfile);
    } catch (e) {
      return Left('Failed to create profile: ${e.toString()}');
    }
  }

  Future<Either<String, ProfileModel>> updateProfile(ProfileModel profile) async {
    try {
      final response = await _dio.put('/updateProfile', data: profile.toJson());
      final updatedProfile = ProfileModel.fromJson(response.data);
      return Right(updatedProfile);
    } catch (e) {
      return Left('Failed to update profile: ${e.toString()}');
    }
  }
}