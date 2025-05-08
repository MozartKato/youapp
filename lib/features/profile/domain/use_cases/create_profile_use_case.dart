import 'package:dartz/dartz.dart';
import '../../data/models/profile_model.dart';
import '../../data/repository/profile_repository.dart';

class CreateProfileUseCase {
  final ProfileRepository repository;

  CreateProfileUseCase(this.repository);

  Future<Either<String, ProfileModel>> call(ProfileModel profile) async {
    return await repository.createProfile(profile);
  }
}