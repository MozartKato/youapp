import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../lib/features/auth/presentation/widgets/custom_text_field.dart'; // Perbaiki path

void main() {
  testWidgets('CustomTextField renders correctly and responds to input', (WidgetTester tester) async {
    String inputText = '';
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomTextField(
            label: 'Email',
            onChanged: (value) => inputText = value,
          ),
        ),
      ),
    );

    expect(find.text('Email'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'test@example.com');
    await tester.pump();
    expect(inputText, 'test@example.com');
  });
}