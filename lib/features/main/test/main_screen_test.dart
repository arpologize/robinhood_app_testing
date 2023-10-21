import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';

import 'package:robinhood_app_testing/constants/constants.dart';
import 'package:robinhood_app_testing/features/main/views/main_screen.dart';
import 'package:robinhood_app_testing/features/screen_lock/test/screen_lock_screen_test.dart';
import 'package:robinhood_app_testing/main.dart' as app;

import '../../screen_lock/views/screen_lock_screen.dart';
import '../components/task_item_widget.dart';

void main() {
  // Command for run test
  // flutter drive --driver=test_driver/integration_test.dart --target=lib/features/main/test/main_screen_test.dart
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Testing main", (WidgetTester tester) async {
    print("== Start Testing main screen ==");
    app.main();
    await tester.pumpAndSettle();
    if (tester.any(find.byType(ScreenLockScreen))) {
      await testLockScreen(tester);
      await testMain(tester);
    } else {
      await tester.pumpAndSettle();
      expect(find.byType(MainScreen), findsOneWidget);
      await testMain(tester);
    }
  });
}

Future<void> pumpUntil(
  WidgetTester tester,
  Finder finder, {
  bool isFound = true,
  Duration timeout = const Duration(seconds: 30),
}) async {
  bool timerDone = false;
  final timer =
      Timer(timeout, () => throw TimeoutException("Pump until has timed out"));
  while (timerDone != true) {
    await tester.pump();
    final check = isFound ? tester.any(finder) : !tester.any(finder);
    if (check) {
      timerDone = true;
    }
  }
  timer.cancel();
}

Future<void> testMain(WidgetTester tester) async {
  final doingButton = find.byKey(const Key(taskStatusDoing));
  final todoButton = find.byKey(const Key(taskStatusTodo));
  final doneButton = find.byKey(const Key(taskStatusDone));
  await tester.pumpAndSettle();
  await testLoadApi(tester);
  await tester.tap(doingButton);
  await testLoadApi(tester);
  await tester.tap(doneButton);
  await testLoadApi(tester);
  await tester.tap(todoButton);
  await testLoadApi(tester);
  print("== Start Delete Task ==");
  await tester.drag(find.byType(Dismissible).first, const Offset(500, 0));
  await tester.pumpAndSettle();
  expect(find.text('Delete success'), findsOneWidget);
  print("== Delete Task Success ==");
  await pumpUntil(
      isFound: false,
      tester,
      find.byKey(
        const Key(snackbarKey),
      ));
  await testChangePincode(tester);
}

Future<void> testChangePincode(WidgetTester tester) async {
  print("== Start Testing change pincode ==");
  final changePinButton = find.byKey(const Key(changePincodeKey));
  await tester.pumpAndSettle();
  await tester.tap(changePinButton);
  await tester.pumpAndSettle(Duration(seconds: 2));
  print("== Change pincode open ==");
  expect(find.text('Enter new password'), findsOneWidget);
  const keypadConfig = KeyPadConfig();
  final keyPad1 = find.byKey(Key('pad${keypadConfig.displayStrings[1]}'));
  for (int i = 0; i < 12; i++) {
    await tester.pumpAndSettle();
    await tester.tap(keyPad1);
  }
  await tester.pumpAndSettle();
  expect(find.text('Confirm your password'), findsNothing);
  print("== Change pincode Success ==");
}

Future<void> testLoadApi(WidgetTester tester) async {
  await tester.pump();
  await pumpUntil(tester, find.byType(TaskItemWidget));
  expect(find.byType(TaskItemWidget), findsAny);
  print("== Load api success ==");
  await tester.pumpAndSettle();
}
