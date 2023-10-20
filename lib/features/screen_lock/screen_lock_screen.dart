import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:robinhood_app_testing/config/themes/themes.dart';
import 'package:robinhood_app_testing/features/screen_lock/controllers/screen_lock_controller.dart';
import 'package:robinhood_app_testing/features/screen_lock/states/auth_state.dart';

class ScreenLockScreen extends ConsumerStatefulWidget {
  const ScreenLockScreen({
    Key? key,
  }) : super(key: key);

  @override
  ScreenLockScreenState createState() => ScreenLockScreenState();
}

class ScreenLockScreenState extends ConsumerState<ScreenLockScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _openScreenLock();
    });
    super.initState();
  }

  void _openScreenLock() {
    screenLock(
      context: context,
      title: Text(
        'Enter your password',
        style:
            CustomTextStyles.header2.copyWith(color: CustomColors.text3Color),
      ),
      correctString: ref.watch(screenLockControllerProvider).pincode,
      canCancel: false,
      onUnlocked: () {
        ref.read(authState.notifier).setState(true);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: CustomColors.onBackgroundColor,
        body: SafeArea(
          child: Container(),
        ));
  }
}
