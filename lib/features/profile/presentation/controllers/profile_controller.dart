import 'package:get/get.dart';
import '../../domain/use_cases/get_profile_use_case.dart';
import '../../domain/use_cases/create_profile_use_case.dart';
import '../../domain/use_cases/update_profile_use_case.dart';
import '../../data/models/profile_model.dart';

class ProfileController extends GetxController {
  final GetProfileUseCase getProfileUseCase;
  final CreateProfileUseCase createProfileUseCase;
  final UpdateProfileUseCase updateProfileUseCase;

  ProfileController({
    required this.getProfileUseCase,
    required this.createProfileUseCase,
    required this.updateProfileUseCase,
  });

  final profile = Rxn<ProfileModel>();
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

  Future<void> createProfile(ProfileModel newProfile) async {
    isLoading.value = true;
    final result = await createProfileUseCase(newProfile);
    isLoading.value = false;

    result.fold(
          (error) => Get.snackbar('Error', error),
          (data) => profile.value = data,
    );
  }

  Future<void> updateProfile(ProfileModel updatedProfile) async {
    isLoading.value = true;
    final result = await updateProfileUseCase(updatedProfile);
    isLoading.value = false;

    result.fold(
          (error) => Get.snackbar('Error', error),
          (data) => profile.value = data,
    );
  }
}