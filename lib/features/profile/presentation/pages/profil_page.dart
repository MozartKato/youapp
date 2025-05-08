import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Obx(() => controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Email: ${controller.profile.value.email}'),
            Text('Username: ${controller.profile.value.username}'),
            Text('Name: ${controller.profile.value.name}'),
            Text('Birthday: ${controller.profile.value.birthday}'),
            Text('Horoscope: ${controller.profile.value.horoscope}'),
            Text('Height: ${controller.profile.value.height} cm'),
            Text('Weight: ${controller.profile.value.weight} kg'),
            Text('Interests: ${controller.profile.value.interests.join(', ')}'),
          ],
        ),
      )),
    );
  }
}