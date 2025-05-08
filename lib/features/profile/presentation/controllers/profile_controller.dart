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

  final Rx<ProfileModel> profile = ProfileModel(
    email: '',
    username: '',
    name: '',
    birthday: '',
    horoscope: '',
    height: 0,
    weight: 0,
    interests: [],
  ).obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    isLoading.value = true;
    final result = await getProfileUseCase();
    result.fold(
          (error) => Get.snackbar('Error', error),
          (data) => profile.value = data,
    );
    isLoading.value = false;
  }

  Future<void> createProfile(ProfileModel profileData) async {
    isLoading.value = true;
    final result = await createProfileUseCase(profileData);
    result.fold(
          (error) => Get.snackbar('Error', error),
          (data) => profile.value = data,
    );
    isLoading.value = false;
  }

  Future<void> updateProfile(ProfileModel profileData) async {
    isLoading.value = true;
    final result = await updateProfileUseCase(profileData);
    result.fold(
          (error) => Get.snackbar('Error', error),
          (data) => profile.value = data,
    );
    isLoading.value = false;
  }
}