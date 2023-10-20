import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:robinhood_app_testing/features/screen_lock/states/auth_state.dart';

import '../../../constants/constants.dart';

class ScreenLockController extends ChangeNotifier {
  ScreenLockController(this.ref) : super() {
    handleUserInteraction();
  }
  final Ref ref;
  String _pincode = "123456";
  String get pincode => _pincode;
  String pincodeInput = '';
  Timer? _timerInteract;
  void setPincode(String pincode) {
    _pincode = pincode;
    notifyListeners();
  }

  void handleUserInteraction() {
    _timerInteract?.cancel();
    _timerInteract = Timer.periodic(const Duration(seconds: timeInactive), (_) {
      _timerInteract?.cancel();
      if (ref.read(authState)) ref.read(authState.notifier).setState(false);
    });
  }
}

final screenLockControllerProvider =
    ChangeNotifierProvider<ScreenLockController>(
        (ref) => ScreenLockController(ref));
