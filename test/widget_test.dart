import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:robinhood_app_testing/constants/constants.dart';
import 'package:robinhood_app_testing/features/main/controllers/main_controller.dart';
import 'package:robinhood_app_testing/features/screen_lock/controllers/screen_lock_controller.dart';

/// Mocks a callback function on which you can use verify
class MockCallbackFunction extends Mock {
  call();
}

void main() {
  group('MainPageController', () {
    late MainPageController mainPageController;
    final notifyListenerCallback = MockCallbackFunction();

    setUp(() {
      mainPageController = MainPageController(null)
        ..addListener(notifyListenerCallback);
      reset(notifyListenerCallback);
    });

    test('Test Set TaskStatus', () {
      mainPageController.setTaskStatus(TaskStatus.doing);
      expect(mainPageController.taskStatus, TaskStatus.doing);
      verify(notifyListenerCallback()).called(1);
    });
  });

  group('ScreenLockController', () {
    late ScreenLockController screenLockController;
    final notifyListenerCallback = MockCallbackFunction();

    setUp(() {
      screenLockController = ScreenLockController(null)
        ..addListener(notifyListenerCallback);
      reset(notifyListenerCallback);
    });

    test('Test set pincode', () {
      screenLockController.setPincode('123456');
      expect(screenLockController.pincode, '123456');
      verify(notifyListenerCallback()).called(1);
    });

    test('Test time inactive', () async {
      screenLockController.handleUserInteraction();
      await Future.delayed(const Duration(seconds: timeInactive));
      expect(screenLockController.isTimeout, true);
    });
  });
}
