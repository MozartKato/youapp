import 'package:flutter/material.dart';
import '../../../../core/utils/zodiac_utils.dart';

class ZodiacWidget extends StatelessWidget {
  final String birthday;

  const ZodiacWidget({super.key, required this.birthday});

  @override
  Widget build(BuildContext context) {
    final zodiac = ZodiacUtils.getZodiac(birthday);
    return Text('Zodiac: $zodiac', style: const TextStyle(fontSize: 16));
  }
}