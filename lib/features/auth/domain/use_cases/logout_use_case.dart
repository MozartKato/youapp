import 'package:dartz/dartz.dart';
import '../../data/repository/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository repository;

  LogoutUseCase(this.repository);

  Future<Either<String, bool>> call() async {
    return await repository.logout();
  }
}