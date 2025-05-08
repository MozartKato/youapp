import 'package:dartz/dartz.dart';
import 'package:youapp/features/profile/domain/entities/profile.dart';
import '../../data/repository/profile_repository.dart';

class GetProfileUseCase {
  final ProfileRepository repository;

  GetProfileUseCase(this.repository);

  Future<Either<String, Profile>> call() async {
    return await repository.getProfile();
  }
}