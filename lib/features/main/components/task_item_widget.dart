import 'package:flutter/material.dart';
import 'package:robinhood_app_testing/config/themes/custom_colors.dart';
import 'package:robinhood_app_testing/constants/constants.dart';
import 'package:robinhood_app_testing/features/main/models/task_list_model.dart';

import '../../../config/themes/custom_text_styles.dart';

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(kPaddingPage),
      color: CustomColors.primaryColor.withOpacity(0.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            task.title ?? '',
            style: CustomTextStyles.title2,
          ),
          Text(
            task.description ?? '',
            style: CustomTextStyles.subTitle2,
          )
        ],
      ),
    );
  }
}
