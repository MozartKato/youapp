import 'package:get/get.dart';
import '../../domain/use_cases/login_use_case.dart';
import '../../domain/use_cases/register_use_case.dart';
import '../../domain/use_cases/logout_use_case.dart';
import '../../data/repository/auth_repository.dart'; // Impor AuthRepository
import '../../../profile/data/repository/profile_repository.dart'; // Impor ProfileRepository
import '../../../../routes/app_routes.dart'; // Impor AppRoutes

class AuthController extends GetxController {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final LogoutUseCase logoutUseCase;

  AuthController(this.loginUseCase, this.registerUseCase, this.logoutUseCase);

  final email = ''.obs;
  final username = ''.obs;
  final password = ''.obs;
  final isLoading = false.obs;
  final RxBool isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    final repo = Get.find<AuthRepository>();
    final token = await repo.getStoredToken();
    if (token != null) {
      print('Auto-login with token: $token');
      final profileRepo = Get.find<ProfileRepository>();
      final result = await profileRepo.getProfile();
      result.fold(
            (error) {
          print('Auto-login failed: $error');
          isLoggedIn.value = false;
        },
            (success) {
          isLoggedIn.value = true;
          Get.offNamed(AppRoutes.profile);
        },
      );
    } else {
      print('No stored token found');
      isLoggedIn.value = false;
    }
  }

  Future<void> login() async {
    isLoading.value = true;
    final result = await loginUseCase(email.value, username.value, password.value);
    isLoading.value = false;
    result.fold(
          (error) => Get.snackbar('Error', error),
          (success) {
        isLoggedIn.value = true;
        Get.offNamed(AppRoutes.profile);
      },
    );
  }

  Future<void> register() async {
    isLoading.value = true;
    final result = await registerUseCase(email.value, username.value, password.value);
    isLoading.value = false;
    result.fold(
          (error) => Get.snackbar('Error', error),
          (success) {
        isLoggedIn.value = true;
        Get.offNamed(AppRoutes.profile);
      },
    );
  }

  Future<void> logout() async {
    isLoading.value = true;
    final result = await logoutUseCase();
    isLoading.value = false;
    result.fold(
          (error) => Get.snackbar('Error', error),
          (success) {
        isLoggedIn.value = false;
        Get.offAllNamed(AppRoutes.login);
      },
    );
  }
}