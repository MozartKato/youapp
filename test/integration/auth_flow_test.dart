import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../lib/main.dart' as app;
import 'auth_flow_test.mocks.dart';

@GenerateNiceMocks([MockSpec<FlutterSecureStorage>()])
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Login flow navigates to profile page', (WidgetTester tester) async {
    // Inisialisasi mock di dalam testWidgets
    final mockStorage = MockFlutterSecureStorage();
    when(mockStorage.read(key: anyNamed('key'))).thenAnswer((_) async => 'mock_token');
    when(mockStorage.write(key: anyNamed('key'), value: anyNamed('value')))
        .thenAnswer((_) async => Future.value());
    when(mockStorage.delete(key: anyNamed('key'))).thenAnswer((_) async => Future.value());

    app.main();
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).at(0), 'ff@ff.com'); // Email
    await tester.enterText(find.byType(TextField).at(1), 'ff99'); // Username
    await tester.enterText(find.byType(TextField).at(2), '12345678'); // Password
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    expect(find.text('Profile'), findsOneWidget);
  }, timeout: const Timeout(Duration(seconds: 30)));

  tearDown(() async {
    // Tidak perlu tester di sini, cukup pastikan frame selesai
  });
}