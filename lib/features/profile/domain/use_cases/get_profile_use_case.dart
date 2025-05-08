import 'package:dartz/dartz.dart';
import '../../data/models/profile_model.dart';
import '../../data/repository/profile_repository.dart';

class GetProfileUseCase {
  final ProfileRepository repository;

  GetProfileUseCase(this.repository);

  Future<Either<String, ProfileModel>> call() async {
    return await repository.getProfile();
  }
}