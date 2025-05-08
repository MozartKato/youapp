import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../widgets/custom_text_field.dart';

class LoginPage extends GetView<AuthController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomTextField(
              label: 'Email',
              onChanged: (value) => controller.email.value = value,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: 'Username',
              onChanged: (value) => controller.username.value = value,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: 'Password',
              onChanged: (value) => controller.password.value = value,
              obscureText: true, // Sekarang parameter ini didefinisikan
            ),
            const SizedBox(height: 24),
            Obx(() => ElevatedButton(
              onPressed: controller.isLoading.value ? null : () => controller.login(),
              child: controller.isLoading.value
                  ? const CircularProgressIndicator()
                  : const Text('Login'),
            )),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => Get.toNamed('/register'),
              child: const Text('Don\'t have an account? Register'),
            ),
          ],
        ),
      ),
    );
  }
}