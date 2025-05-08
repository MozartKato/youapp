import 'package:dartz/dartz.dart';
import '../../data/repository/profile_repository.dart';
import '../entities/profile.dart';

class UpdateProfileUseCase {
  final ProfileRepository repository;

  UpdateProfileUseCase(this.repository);

  Future<Either<String, Profile>> call(Profile profile) async {
    return await repository.updateProfile(profile);
  }
}