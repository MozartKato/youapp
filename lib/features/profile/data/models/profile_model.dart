import 'package:get/get.dart';
import '../../domain/entities/profile.dart';
import '../../domain/use_cases/get_profile_use_case.dart';
import '../../domain/use_cases/create_profile_use_case.dart';
import '../../domain/use_cases/update_profile_use_case.dart';

class ProfileController extends GetxController {
  final GetProfileUseCase getProfileUseCase;
  final CreateProfileUseCase createProfileUseCase;
  final UpdateProfileUseCase updateProfileUseCase;

  ProfileController({
    required this.getProfileUseCase,
    required this.createProfileUseCase,
    required this.updateProfileUseCase,
  });

  final profile = Profile(
    email: '',
    username: '',
    name: '',
  ).obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    isLoading.value = true;
    final result = await getProfileUseCase();
    isLoading.value = false;
    result.fold(
          (error) => Get.snackbar('Error', error),
          (data) => profile.value = data,
    );
  }

  Future<void> createProfile(String name) async {
    isLoading.value = true;
    final result = await createProfileUseCase(
      name: name,
      birthday: '',
      height: 0,
      weight: 0,
      interests: [],
    );
    isLoading.value = false;
    result.fold(
          (error) => Get.snackbar('Error', error),
          (data) => profile.value = data,
    );
  }

  Future<void> updateProfile(Profile updatedProfile) async {
    isLoading.value = true;
    final result = await updateProfileUseCase(updatedProfile);
    isLoading.value = false;
    result.fold(
          (error) => Get.snackbar('Error', error),
          (data) => profile.value = data,
    );
  }
}