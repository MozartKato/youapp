import 'package:get/get.dart';
import '../../domain/use_cases/login_use_case.dart';
import '../../domain/use_cases/register_use_case.dart';
import '../../domain/use_cases/logout_use_case.dart';
import '../../../../routes/app_routes.dart';

class AuthController extends GetxController {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final LogoutUseCase logoutUseCase;

  AuthController(this.loginUseCase, this.registerUseCase, this.logoutUseCase);

  final email = ''.obs;
  final username = ''.obs;
  final password = ''.obs;
  final isLoading = false.obs;

  Future<void> login() async {
    isLoading.value = true;
    final result = await loginUseCase(email.value, username.value, password.value);
    isLoading.value = false;

    result.fold(
          (error) => Get.snackbar('Error', error),
          (success) => Get.offNamed(AppRoutes.profile),
    );
  }

  Future<void> register() async {
    isLoading.value = true;
    final result = await registerUseCase(email.value, username.value, password.value);
    isLoading.value = false;

    result.fold(
          (error) => Get.snackbar('Error', error),
          (success) => Get.offNamed(AppRoutes.profile),
    );
  }

  Future<void> logout() async {
    isLoading.value = true;
    final result = await logoutUseCase();
    isLoading.value = false;

    result.fold(
          (error) => Get.snackbar('Error', error),
          (success) => Get.offAllNamed(AppRoutes.login),
    );
  }
}