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
  final Ref? ref;
  String _pincode = "123456";
  String get pincode => _pincode;
  String pincodeInput = '';
  Timer? timerInteract;
  bool isTimeout = false;
  void setPincode(String pincode) {
    _pincode = pincode;
    notifyListeners();
  }

  void handleUserInteraction() {
    isTimeout = false;
    timerInteract?.cancel();
    timerInteract = Timer.periodic(const Duration(seconds: timeInactive), (_) {
      timerInteract?.cancel();
      isTimeout = true;
      if (ref != null && ref!.read(authState)) {
        ref!.read(authState.notifier).setState(false);
      }
    });
  }
}

final screenLockControllerProvider =
    ChangeNotifierProvider<ScreenLockController>(
        (ref) => ScreenLockController(ref));
