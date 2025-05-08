import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../data/repository/auth_repository.dart';
import '../../domain/use_cases/login_use_case.dart';
import '../../domain/use_cases/register_use_case.dart';
import '../../domain/use_cases/logout_use_case.dart';
import '../../../../routes/app_routes.dart';
import '../../../profile/data/repository/profile_repository.dart';

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
  final RxBool passwordVisible = false.obs;
  final RxBool isFormValid = false.obs;

  @override
  void onInit() {
    super.onInit();
    debounce(email, (_) => _validateForm(), time: const Duration(milliseconds: 300));
    debounce(username, (_) => _validateForm(), time: const Duration(milliseconds: 300));
    debounce(password, (_) => _validateForm(), time: const Duration(milliseconds: 300));
    checkLoginStatus();
  }

  void _validateForm() {
    isFormValid.value = email.value.isNotEmpty &&
        username.value.isNotEmpty &&
        password.value.isNotEmpty;
  }

  void togglePasswordVisibility() {
    passwordVisible.value = !passwordVisible.value;
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

  Future<void> register(String email, String username, String password) async {
    isLoading.value = true;
    // Langkah 1: Register user
    final registerResult = await registerUseCase(email, username, password);
    registerResult.fold(
          (error) {
        isLoading.value = false;
        Get.snackbar('Error', error);
      },
          (registerSuccess) async {
        // Langkah 2: Login otomatis untuk dapatkan token
        final loginResult = await loginUseCase(email, username, password);
        loginResult.fold(
              (error) {
            isLoading.value = false;
            Get.snackbar('Error', 'Failed to login after register: $error');
          },
              (loginSuccess) async {
            // Langkah 3: Create profile setelah login sukses
            final profileRepo = Get.find<ProfileRepository>();
            final createProfileResult = await profileRepo.createProfile(
              name: username,
              birthday: '',
              height: 0,
              weight: 0,
              interests: [],
            );
            isLoading.value = false;
            createProfileResult.fold(
                  (error) => Get.snackbar('Error', 'Failed to create profile: $error'),
                  (profileSuccess) {
                isLoggedIn.value = true;
                Get.offNamed(AppRoutes.profile);
              },
            );
          },
        );
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