import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final Function(String) onChanged;
  final bool obscureText; // Tambahkan parameter ini

  const CustomTextField({
    super.key,
    required this.label,
    required this.onChanged,
    this.obscureText = false, // Default ke false
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      obscureText: obscureText, // Gunakan parameter
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}