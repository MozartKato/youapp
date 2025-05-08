import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import '../../../../routes/app_routes.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  // Fungsi untuk hitung umur dari birthday (format: dd/MM/yyyy)
  int _calculateAge(String birthday) {
    if (birthday.isEmpty) return 0;
    final parts = birthday.split('/');
    if (parts.length != 3) return 0;
    final birthDate = DateTime(int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
    final now = DateTime.now();
    int age = now.year - birthDate.year;
    if (now.month < birthDate.month || (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Obx(() => Text(
          '@${controller.profile.value.username}',
          style: const TextStyle(color: Colors.white),
        )),
        backgroundColor: const Color(0xFF16213E), // Dark background
      ),
      backgroundColor: const Color(0xFF16213E), // Dark background
      body: Obx(() => controller.isLoading.value
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Image Section
              Container(
                height: 200,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('https://images.pexels.com/photos/31967054/pexels-photo-31967054/free-photo-of-red-motorcycle-parked-outdoors-in-madikeri.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'), // Placeholder image
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            controller.profile.value.name.isNotEmpty
                                ? controller.profile.value.name
                                : '@${controller.profile.value.username}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            _calculateAge(controller.profile.value.birthday) > 0
                                ? '${_calculateAge(controller.profile.value.birthday)}'
                                : '',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          margin: const EdgeInsets.only(right: 5),
                          decoration: BoxDecoration(
                            color: Colors.grey[800],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            controller.profile.value.horoscope.isNotEmpty
                                ? controller.profile.value.horoscope
                                : 'Zodiac',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.grey[800],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            'Pig',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // About Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'About',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.profileForm),
                    child: const Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Birthday: ${controller.profile.value.birthday} (${_calculateAge(controller.profile.value.birthday)})',
                style: TextStyle(color: Colors.grey[400]),
              ),
              Text(
                'Horoscope: ${controller.profile.value.horoscope}',
                style: TextStyle(color: Colors.grey[400]),
              ),
              Text(
                'Zodiac: Pig', // Hardcoded untuk sekarang, bisa diambil dari API nanti
                style: TextStyle(color: Colors.grey[400]),
              ),
              Text(
                'Height: ${controller.profile.value.height} cm',
                style: TextStyle(color: Colors.grey[400]),
              ),
              Text(
                'Weight: ${controller.profile.value.weight} kg',
                style: TextStyle(color: Colors.grey[400]),
              ),
              const SizedBox(height: 20),
              // Interest Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Interest',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.profileForm),
                    child: const Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                controller.profile.value.interests.isNotEmpty
                    ? controller.profile.value.interests.join(', ')
                    : 'Add in your interest to find a better match',
                style: TextStyle(color: Colors.grey[400]),
              ),
            ],
          ),
        ),
      )),
    );
  }
}