import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:robinhood_app_testing/config/themes/themes.dart';
import 'package:robinhood_app_testing/features/screen_lock/controllers/screen_lock_controller.dart';
import 'package:robinhood_app_testing/features/screen_lock/states/auth_state.dart';

import '../components/screen_lock_custom.dart';

class ScreenLockScreen extends ConsumerStatefulWidget {
  const ScreenLockScreen({
    Key? key,
  }) : super(key: key);

  @override
  ScreenLockScreenState createState() => ScreenLockScreenState();
}

class ScreenLockScreenState extends ConsumerState<ScreenLockScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: CustomColors.onBackground2Color,
        body: SafeArea(
          child: ScreenLockCustom(
            title: Text(
              'Enter your password',
              style: CustomTextStyles.header2
                  .copyWith(color: CustomColors.text3Color),
            ),
            correctString: ref.watch(screenLockControllerProvider).pincode,
            onUnlocked: () {
              ref.read(authState.notifier).setState(true);
            },
          ),
        ));
  }
}
