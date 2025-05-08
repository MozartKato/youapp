import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/profile_model.dart';
import '../controllers/profile_controller.dart';
import '../../../../core/utils/zodiac_utils.dart';

class ProfileFormPage extends GetView<ProfileController> {
  const ProfileFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final birthdayController = TextEditingController();
    final heightController = TextEditingController();
    final weightController = TextEditingController();
    final interestsController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name is required';
                    }
                    if (value.length > 50) {
                      return 'Name must be less than 50 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: birthdayController,
                  decoration: const InputDecoration(
                    labelText: 'Birthday (yyyy-MM-dd)',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Birthday is required';
                    }
                    try {
                      DateTime.parse(value);
                      return null;
                    } catch (e) {
                      return 'Invalid date format (use yyyy-MM-dd)';
                    }
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: heightController,
                  decoration: const InputDecoration(
                    labelText: 'Height (cm)',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Height is required';
                    }
                    final height = int.tryParse(value);
                    if (height == null || height < 50 || height > 250) {
                      return 'Height must be between 50 and 250 cm';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: weightController,
                  decoration: const InputDecoration(
                    labelText: 'Weight (kg)',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Weight is required';
                    }
                    final weight = int.tryParse(value);
                    if (weight == null || weight < 20 || weight > 200) {
                      return 'Weight must be between 20 and 200 kg';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: interestsController,
                  decoration: const InputDecoration(
                    labelText: 'Interests (comma-separated)',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Interests are required';
                    }
                    final interests = value.split(',').map((e) => e.trim()).toList();
                    if (interests.length > 10) {
                      return 'Maximum 10 interests allowed';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                Obx(() => ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : () {
                    if (formKey.currentState!.validate()) {
                      final profile = controller.profile.value;
                      final newProfile = ProfileModel(
                        email: profile?.email ?? '',
                        username: profile?.username ?? '',
                        name: nameController.text,
                        birthday: birthdayController.text,
                        horoscope: ZodiacUtils.getZodiac(birthdayController.text),
                        height: int.parse(heightController.text),
                        weight: int.parse(weightController.text),
                        interests: interestsController.text
                            .split(',')
                            .map((e) => e.trim())
                            .toList(),
                      );
                      if (profile == null) {
                        controller.createProfile(newProfile);
                      } else {
                        controller.updateProfile(newProfile);
                      }
                    }
                  },
                  child: controller.isLoading.value
                      ? const CircularProgressIndicator()
                      : const Text('Save Profile'),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}