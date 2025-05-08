import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:youapp/features/auth/domain/use_cases/login_use_case.dart';
import 'package:youapp/features/auth/domain/use_cases/register_use_case.dart';
import 'package:youapp/features/auth/domain/use_cases/logout_use_case.dart';
import 'package:youapp/features/auth/presentation/controllers/auth_controller.dart';
import 'package:youapp/features/auth/data/models/login_model.dart';
import 'package:youapp/features/auth/data/models/register_model.dart';
import 'auth_controller_test.mocks.dart';

@GenerateNiceMocks([MockSpec<LoginUseCase>(), MockSpec<RegisterUseCase>(), MockSpec<LogoutUseCase>()])
void main() {
  late AuthController controller;
  late MockLoginUseCase mockLoginUseCase;
  late MockRegisterUseCase mockRegisterUseCase;
  late MockLogoutUseCase mockLogoutUseCase;

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    mockRegisterUseCase = MockRegisterUseCase();
    mockLogoutUseCase = MockLogoutUseCase();
    controller = AuthController(mockLoginUseCase, mockRegisterUseCase, mockLogoutUseCase);
    Get.testMode = true;
  });

  test('login should call use case and update loading state', () async {
    when(mockLoginUseCase(any, any, any))
        .thenAnswer((_) async => Right(LoginModel(accessToken: 'test_token')));

    controller.email.value = 'test@example.com';
    controller.username.value = 'testuser'; // Tambahkan username
    controller.password.value = 'password';
    await controller.login();

    expect(controller.isLoading.value, false);
    verify(mockLoginUseCase('test@example.com', 'testuser', 'password')).called(1);
  });

  test('register should call use case and update loading state', () async {
    when(mockRegisterUseCase(any, any, any))
        .thenAnswer((_) async => Right(RegisterModel(message: 'Success', accessToken: 'test_token')));

    controller.email.value = 'test@example.com';
    controller.username.value = 'testuser';
    controller.password.value = 'password';
    await controller.register();

    expect(controller.isLoading.value, false);
    verify(mockRegisterUseCase('test@example.com', 'testuser', 'password')).called(1);
  });
}