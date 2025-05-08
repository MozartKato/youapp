import 'package:dartz/dartz.dart';
import '../../data/repository/profile_repository.dart';
import '../entities/profile.dart';

class CreateProfileUseCase {
  final ProfileRepository repository;

  CreateProfileUseCase(this.repository);

  Future<Either<String, Profile>> call({
    required String name,
    String birthday = '',
    int height = 0,
    int weight = 0,
    List<String> interests = const [],
  }) async {
    return await repository.createProfile(
      name: name,
      birthday: birthday,
      height: height,
      weight: weight,
      interests: interests,
    );
  }
}