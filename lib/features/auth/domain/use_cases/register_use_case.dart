import 'package:dartz/dartz.dart';
import '../../data/models/register_model.dart';
import '../../data/repository/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<Either<String, RegisterModel>> call(
      String email, String username, String password) async {
    return await repository.register(email, username, password);
  }
}