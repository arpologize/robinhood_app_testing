import 'package:flutter/material.dart';
import 'package:robinhood_app_testing/config/themes/custom_colors.dart';

import '../../../config/themes/custom_text_styles.dart';

class TaskStatusWidget extends StatelessWidget {
  const TaskStatusWidget(
      {Key? key,
      required this.name,
      required this.isSelect,
      required this.onTap})
      : super(key: key);

  final String name;
  final bool isSelect;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        decoration: BoxDecoration(
            color: isSelect
                ? CustomColors.primaryColor
                : CustomColors.secondaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(30))),
        child: Center(
          child: Text(name,
              style: CustomTextStyles.title1.copyWith(
                  color: isSelect
                      ? CustomColors.text3Color
                      : CustomColors.text4Color)),
        ),
      ),
    );
  }
}
