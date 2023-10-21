import 'package:flutter/material.dart';

import '../config/themes/custom_colors.dart';

class Loading extends StatelessWidget {
  final double height;
  final Color color;
  final double loadingSize;

  const Loading(
      {Key? key,
      this.height = 110,
      this.color = CustomColors.primaryColor,
      this.loadingSize = 30})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: height,
        child: Center(
          child: SizedBox(
            height: loadingSize,
            width: loadingSize,
            child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(color)),
          ),
        ),
      ),
    );
  }
}
