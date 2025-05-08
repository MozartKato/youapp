import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import '../../lib/features/profile/presentation/pages/profile_form_page.dart';
import '../../lib/features/profile/presentation/controllers/profile_controller.dart';
import '../../lib/features/profile/domain/use_cases/get_profile_use_case.dart';
import '../../lib/features/profile/domain/use_cases/create_profile_use_case.dart';
import '../../lib/features/profile/domain/use_cases/update_profile_use_case.dart';
import '../../lib/features/profile/data/repository/profile_repository.dart';
import '../../lib/core/constants/strings.dart'; // Tambahkan import ini

void main() {
  setUp(() {
    // Inisialisasi dependensi GetX
    Get.testMode = true;
    Get.put(ProfileRepository());
    Get.put(GetProfileUseCase(Get.find()));
    Get.put(CreateProfileUseCase(Get.find()));
    Get.put(UpdateProfileUseCase(Get.find()));
    Get.put(ProfileController(
      getProfileUseCase: Get.find(),
      createProfileUseCase: Get.find(),
      updateProfileUseCase: Get.find(),
    ));
  });

  testWidgets('ProfileFormPage validates inputs correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      GetMaterialApp(
        home: const ProfileFormPage(),
      ),
    );

    // Input invalid
    await tester.enterText(find.byType(TextFormField).at(0), ''); // Name kosong
    await tester.enterText(find.byType(TextFormField).at(1), 'invalid-date'); // Birthday salah
    await tester.enterText(find.byType(TextFormField).at(2), '300'); // Height invalid
    await tester.enterText(find.byType(TextFormField).at(3), '10'); // Weight invalid
    await tester.enterText(find.byType(TextFormField).at(4), ''); // Interests kosong
    await tester.tap(find.text('Save Profile'));
    await tester.pump();

    expect(find.text(AppStrings.nameRequired), findsOneWidget);
    expect(find.text(AppStrings.invalidDate), findsOneWidget);
    expect(find.text(AppStrings.heightRange), findsOneWidget);
    expect(find.text(AppStrings.weightRange), findsOneWidget);
    expect(find.text(AppStrings.interestsRequired), findsOneWidget);
  });

  tearDown(() {
    Get.reset(); // Bersihkan GetX setelah setiap test
  });
}