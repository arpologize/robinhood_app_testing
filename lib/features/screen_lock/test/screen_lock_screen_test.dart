import 'package:flutter/widgets.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:robinhood_app_testing/features/main/views/main_screen.dart';
import 'package:robinhood_app_testing/features/screen_lock/views/screen_lock_screen.dart';
import 'package:robinhood_app_testing/main.dart' as app;

void main() {
  // Command for run test
  // flutter drive --driver=test_driver/integration_test.dart --target=lib/features/screen_lock/test/screen_lock_screen_test.dart
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Testing pincode", (WidgetTester tester) async {
    app.main();
    await testLockScreen(tester);
  });
}

Future<void> testLockScreen(WidgetTester tester) async {
  const keypadConfig = KeyPadConfig();
  final keyPad1 = find.byKey(Key('pad${keypadConfig.displayStrings[1]}'));
  final keyPad2 = find.byKey(Key('pad${keypadConfig.displayStrings[2]}'));
  final keyPad3 = find.byKey(Key('pad${keypadConfig.displayStrings[3]}'));
  final keyPad4 = find.byKey(Key('pad${keypadConfig.displayStrings[4]}'));
  final keyPad5 = find.byKey(Key('pad${keypadConfig.displayStrings[5]}'));
  final keyPad6 = find.byKey(Key('pad${keypadConfig.displayStrings[6]}'));
  print("== Start Testing pincode lock screen ==");
  await tester.pumpAndSettle();
  expect(find.byType(ScreenLockScreen), findsOneWidget);
  await tester.pumpAndSettle();
  await tester.tap(keyPad1);
  await tester.pumpAndSettle();
  await tester.tap(keyPad2);
  await tester.pumpAndSettle();
  await tester.tap(keyPad3);
  await tester.pumpAndSettle();
  await tester.tap(keyPad4);
  await tester.pumpAndSettle();
  await tester.tap(keyPad5);
  await tester.pumpAndSettle();
  await tester.tap(keyPad6);
  await tester.pumpAndSettle();
  expect(find.byType(MainScreen), findsOneWidget);
  print("== Testing pincode lock screen success ==");
}
