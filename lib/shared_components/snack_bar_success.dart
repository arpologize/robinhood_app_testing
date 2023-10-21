import 'package:flutter/material.dart';

import 'package:top_snackbar_flutter/custom_snack_bar.dart';

import '../constants/constants.dart';

class SnackBarSuccess extends StatelessWidget {
  const SnackBarSuccess({Key? key, this.text = ''}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return CustomSnackBar.success(
      key: const Key(snackbarKey),
      message: text,
    );
  }
}
