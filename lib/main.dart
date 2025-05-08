import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'features/auth/presentation/controllers/auth_controller.dart';
import 'features/auth/domain/use_cases/login_use_case.dart';
import 'features/auth/domain/use_cases/register_use_case.dart';
import 'features/auth/domain/use_cases/logout_use_case.dart';
import 'features/auth/data/repository/auth_repository.dart';
import 'features/profile/presentation/controllers/profile_controller.dart';
import 'features/profile/domain/use_cases/get_profile_use_case.dart';
import 'features/profile/domain/use_cases/create_profile_use_case.dart';
import 'features/profile/domain/use_cases/update_profile_use_case.dart';
import 'features/profile/data/repository/profile_repository.dart';
import 'routes/app_pages.dart';
import 'core/constants/theme.dart';
import 'routes/app_routes.dart';

void main() {
  // Inisialisasi dependensi untuk autentikasi
  Get.lazyPut<AuthRepository>(() => AuthRepository());
  Get.lazyPut<LoginUseCase>(() => LoginUseCase(Get.find()));
  Get.lazyPut<RegisterUseCase>(() => RegisterUseCase(Get.find()));
  Get.lazyPut<LogoutUseCase>(() => LogoutUseCase(Get.find()));
  Get.lazyPut<AuthController>(
          () => AuthController(Get.find(), Get.find(), Get.find()));

  // Inisialisasi dependensi untuk profil
  Get.lazyPut<ProfileRepository>(() => ProfileRepository());
  Get.lazyPut<GetProfileUseCase>(() => GetProfileUseCase(Get.find()));
  Get.lazyPut<CreateProfileUseCase>(() => CreateProfileUseCase(Get.find()));
  Get.lazyPut<UpdateProfileUseCase>(() => UpdateProfileUseCase(Get.find()));
  Get.lazyPut<ProfileController>(() => ProfileController(
    getProfileUseCase: Get.find(),
    createProfileUseCase: Get.find(),
    updateProfileUseCase: Get.find(),
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'YouApp',
      theme: AppTheme.theme,
      initialRoute: AppRoutes.initial,
      getPages: AppPages.pages,
    );
  }
}