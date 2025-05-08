import 'package:get/get.dart';
import '../features/auth/presentation/pages/login_page.dart';
import '../features/auth/presentation/pages/register_page.dart';
import '../features/profile/presentation/pages/profil_page.dart';
import '../features/profile/presentation/pages/profile_form_page.dart';
import '../features/auth/presentation/controllers/auth_controller.dart';
import '../features/profile/presentation/controllers/profile_controller.dart';
import '../features/auth/domain/use_cases/login_use_case.dart';
import '../features/auth/domain/use_cases/register_use_case.dart';
import '../features/auth/domain/use_cases/logout_use_case.dart';
import '../features/auth/data/repository/auth_repository.dart';
import '../features/profile/domain/use_cases/get_profile_use_case.dart';
import '../features/profile/domain/use_cases/create_profile_use_case.dart';
import '../features/profile/domain/use_cases/update_profile_use_case.dart';
import '../features/profile/data/repository/profile_repository.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.initial,
      page: () {
        final authController = Get.find<AuthController>();
        return authController.isLoggedIn.value ? const ProfilePage() : const LoginPage();
      },
      binding: BindingsBuilder(() {
        Get.lazyPut(() => AuthRepository());
        Get.lazyPut(() => LoginUseCase(Get.find()));
        Get.lazyPut(() => RegisterUseCase(Get.find()));
        Get.lazyPut(() => LogoutUseCase(Get.find()));
        Get.lazyPut(() => AuthController(
          Get.find(),
          Get.find(),
          Get.find(),
        ));
        Get.lazyPut(() => ProfileRepository()); // Pastikan ini ada
        Get.lazyPut(() => GetProfileUseCase(Get.find()));
        Get.lazyPut(() => CreateProfileUseCase(Get.find()));
        Get.lazyPut(() => UpdateProfileUseCase(Get.find()));
        Get.lazyPut(() => ProfileController(
          getProfileUseCase: Get.find(),
          createProfileUseCase: Get.find(),
          updateProfileUseCase: Get.find(),
        ));
      }),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => AuthController(
          Get.find(),
          Get.find(),
          Get.find(),
        ));
      }),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => RegisterPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => AuthController(
          Get.find(),
          Get.find(),
          Get.find(),
        ));
      }),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfilePage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ProfileRepository());
        Get.lazyPut(() => GetProfileUseCase(Get.find()));
        Get.lazyPut(() => CreateProfileUseCase(Get.find()));
        Get.lazyPut(() => UpdateProfileUseCase(Get.find()));
        Get.lazyPut(() => ProfileController(
          getProfileUseCase: Get.find(),
          createProfileUseCase: Get.find(),
          updateProfileUseCase: Get.find(),
        ));
      }),
    ),
    GetPage(
      name: AppRoutes.profileForm,
      page: () => const ProfileFormPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ProfileRepository());
        Get.lazyPut(() => GetProfileUseCase(Get.find()));
        Get.lazyPut(() => CreateProfileUseCase(Get.find()));
        Get.lazyPut(() => UpdateProfileUseCase(Get.find()));
        Get.lazyPut(() => ProfileController(
          getProfileUseCase: Get.find(),
          createProfileUseCase: Get.find(),
          updateProfileUseCase: Get.find(),
        ));
      }),
    ),
  ];
}