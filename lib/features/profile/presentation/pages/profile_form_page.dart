import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';

class ProfileFormPage extends GetView<ProfileController> {
  const ProfileFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: const Color(0xFF16213E), // Dark background
      ),
      backgroundColor: const Color(0xFF16213E), // Dark background
      body: const Center(
        child: Text(
          'Profile Form Page - To be implemented',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}