import 'package:flutter/material.dart';

import 'package:top_snackbar_flutter/custom_snack_bar.dart';

import '../constants/constants.dart';

class SnackBarError extends StatelessWidget {
  const SnackBarError({Key? key, this.text = 'ไม่สามารถเลือกเวลาดังกล่าวได้'})
      : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return CustomSnackBar.error(
      key: const Key(snackbarKey),
      message: text,
    );
  }
}
