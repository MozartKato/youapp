import 'package:dartz/dartz.dart';
import '../../data/models/login_model.dart';
import '../../data/repository/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<String, LoginModel>> call(String email, String username, String password) async {
    return await repository.login(email, username, password);
  }
}