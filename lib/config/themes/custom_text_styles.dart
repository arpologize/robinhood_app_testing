import 'package:flutter/material.dart';

import 'custom_colors.dart';

class CustomTextStyles {
  const CustomTextStyles();

  static const TextStyle header1 = TextStyle(
    color: CustomColors.text1Color,
    fontSize: 32,
  );

  static const TextStyle header2 = TextStyle(
    color: CustomColors.text1Color,
    fontSize: 24,
  );

  static const TextStyle header3 = TextStyle(
    color: CustomColors.text1Color,
    fontSize: 20,
  );

  static const TextStyle title1 = TextStyle(
    color: CustomColors.text1Color,
    fontSize: 18,
  );

  static const TextStyle title2 = TextStyle(
      color: CustomColors.text1Color,
      fontSize: 18,
      fontWeight: FontWeight.bold);

  static const TextStyle subTitle1 = TextStyle(
    color: CustomColors.text1Color,
    fontSize: 16,
  );
  static const TextStyle subTitle2 = TextStyle(
    color: CustomColors.text1Color,
    fontSize: 14,
  );
  static const TextStyle body1 = TextStyle(
    color: CustomColors.text1Color,
    fontSize: 16,
  );

  static const TextStyle button1 = TextStyle(
      color: CustomColors.text1Color,
      fontSize: 14,
      fontWeight: FontWeight.w700);
}
