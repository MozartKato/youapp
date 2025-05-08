import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../widgets/custom_text_field.dart';
import '../../../../routes/app_routes.dart';

class LoginPage extends GetView<AuthController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        backgroundColor: const Color(0xFF16213E), // Dark background
      ),
      backgroundColor: const Color(0xFF16213E), // Dark background
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Login',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 40),
            CustomTextField(
              label: 'Email',
              onChanged: (value) => controller.email.value = value,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              label: 'Username',
              onChanged: (value) => controller.username.value = value,
            ),
            const SizedBox(height: 20),
            Obx(() => TextField(
              onChanged: (value) => controller.password.value = value,
              style: const TextStyle(color: Colors.white),
              obscureText: !controller.passwordVisible.value,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[800],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    controller.passwordVisible.value
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () => controller.togglePasswordVisibility(),
                ),
              ),
            )),
            const SizedBox(height: 40),
            Obx(() => ElevatedButton(
              onPressed: controller.isLoading.value || !controller.isFormValid.value
                  ? null
                  : () => controller.login(),
              style: ElevatedButton.styleFrom(
                backgroundColor: controller.isFormValid.value && !controller.isLoading.value
                    ? const Color(0xFF00C4CC) // Cerah saat valid
                    : Colors.grey[700], // Gelap saat invalid
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: controller.isLoading.value
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                'Login',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            )),
            const SizedBox(height: 20),
            Center(
              child: GestureDetector(
                onTap: () => Get.toNamed(AppRoutes.register),
                child: const Text(
                  'No account? Register here',
                  style: TextStyle(
                    color: Color(0xFFFFC107),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}