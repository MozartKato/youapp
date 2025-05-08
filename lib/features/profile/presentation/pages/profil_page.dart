import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_routes.dart';
import '../controllers/profile_controller.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../widgets/zodiac_widget.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.profile.value == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Failed to load profile'),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => controller.fetchProfile(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }
        final profile = controller.profile.value!;
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name: ${profile.name}', style: const TextStyle(fontSize: 18)),
              Text('Email: ${profile.email}', style: const TextStyle(fontSize: 16)),
              Text('Username: ${profile.username}', style: const TextStyle(fontSize: 16)),
              Text('Birthday: ${profile.birthday}', style: const TextStyle(fontSize: 16)),
              ZodiacWidget(birthday: profile.birthday),
              Text('Height: ${profile.height} cm', style: const TextStyle(fontSize: 16)),
              Text('Weight: ${profile.weight} kg', style: const TextStyle(fontSize: 16)),
              Text('Interests: ${profile.interests.join(', ')}', style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Get.toNamed(AppRoutes.profileForm),
                child: const Text('Edit Profile'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => authController.logout(),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Logout'),
              ),
            ],
          ),
        );
      }),
    );
  }
}