import 'package:dartz/dartz.dart';
import '../../data/models/profile_model.dart';
import '../../data/repository/profile_repository.dart';

class UpdateProfileUseCase {
  final ProfileRepository repository;

  UpdateProfileUseCase(this.repository);

  Future<Either<String, ProfileModel>> call(ProfileModel profile) async {
    return await repository.updateProfile(profile);
  }
}