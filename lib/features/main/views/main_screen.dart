import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:robinhood_app_testing/config/themes/themes.dart';
import 'package:robinhood_app_testing/features/main/components/task_item_widget.dart';
import 'package:robinhood_app_testing/features/main/components/task_status_widget.dart';
import 'package:robinhood_app_testing/features/main/controllers/main_controller.dart';
import 'package:robinhood_app_testing/features/main/controllers/tasks_controller.dart';
import 'package:robinhood_app_testing/features/main/models/task_list_model.dart';
import 'package:robinhood_app_testing/features/screen_lock/components/screen_lock_custom.dart';
import 'package:robinhood_app_testing/features/screen_lock/controllers/screen_lock_controller.dart';
import 'package:robinhood_app_testing/shared_components/loading.dart';
import 'package:robinhood_app_testing/utils/extension/extension.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../constants/constants.dart';
import '../../../shared_components/snack_bar_error.dart';
import '../../../shared_components/snack_bar_success.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({
    Key? key,
  }) : super(key: key);

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends ConsumerState<MainScreen> {
  void onTaskStatusTap(TaskStatus taskStatus) {
    ref.read(mainPageControllerProvider).setTaskStatus(taskStatus);
  }

  void _onItemSwipe(Task task) {
    ref.read(tasksControllerProvider.notifier).deleteTask(task).then((value) {
      if (ref.read(tasksControllerProvider).hasError) {
        showTopSnackBar(
            Overlay.of(context), const SnackBarError(text: 'Delete fail'));
      } else if (ref.read(tasksControllerProvider).hasValue) {
        showTopSnackBar(
            Overlay.of(context), const SnackBarSuccess(text: 'Delete success'));
      }
    });
  }

  bool _onNotification(ScrollEndNotification scrollEndNotification) {
    final pageController = ref.watch(mainPageControllerProvider);
    final taskList = ref.watch(tasksControllerProvider);
    final metrics = scrollEndNotification.metrics;
    if (metrics.atEdge) {
      bool isTop = metrics.pixels == 0;
      if (!isTop) {
        ref.read(tasksControllerProvider.notifier).getTaskList(
            offset: ((taskList.value?.totalPages ?? 0) - 1 ==
                    taskList.value?.pageNumber)
                ? taskList.value?.pageNumber ?? 0
                : (taskList.value?.pageNumber ?? 0) + 1,
            status: pageController.taskStatusText);
      }
    }
    return false;
  }

  void createPincode() {
    showDialog<void>(
      context: context,
      builder: (context) => ScreenLockCustom.create(
        digits: 6,
        title: Text(
          'Enter new password',
          style:
              CustomTextStyles.header2.copyWith(color: CustomColors.text3Color),
        ),
        confirmTitle: Text('Confirm your password',
            style: CustomTextStyles.header2
                .copyWith(color: CustomColors.text3Color)),
        onConfirmed: (pincode) => {
          ref.read(screenLockControllerProvider).setPincode(pincode),
          Navigator.of(context).pop()
        },
        cancelButton: const Icon(Icons.close),
        deleteButton: const Icon(Icons.delete),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pageController = ref.watch(mainPageControllerProvider);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: CustomColors.onBackgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              _buildHeader(pageController),
              Expanded(child: _buildTaskList(pageController))
            ],
          ),
        ));
  }

  Widget _buildHeader(MainPageController pageController) {
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: kPaddingPage, horizontal: kPaddingPage),
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                TaskStatusWidget(
                  name: 'To-do',
                  isSelect: pageController.taskStatus == TaskStatus.todo,
                  onTap: () => onTaskStatusTap(TaskStatus.todo),
                  value: taskStatusTodo,
                ),
                TaskStatusWidget(
                  name: 'Doing',
                  isSelect: pageController.taskStatus == TaskStatus.doing,
                  onTap: () => onTaskStatusTap(TaskStatus.doing),
                  value: taskStatusDoing,
                ),
                TaskStatusWidget(
                  name: 'Done',
                  isSelect: pageController.taskStatus == TaskStatus.done,
                  onTap: () => onTaskStatusTap(TaskStatus.done),
                  value: taskStatusDone,
                )
              ],
            ),
          ),
          GestureDetector(
            key: const Key(changePincodeKey),
            onTap: () => createPincode(),
            child: const Icon(Icons.settings),
          )
        ],
      ),
    );
  }

  Widget _buildTaskList(MainPageController pageController) {
    final taskList = ref.watch(tasksControllerProvider);
    return taskList.when(
      data: (taskData) => NotificationListener<ScrollEndNotification>(
        onNotification: (notification) => _onNotification(notification),
        child: GroupedListView<Task, DateTime>(
          elements: taskData.tasks ?? [],
          groupBy: (element) => element.createdAtDate,
          groupComparator: (value1, value2) => value2.compareTo(value1),
          itemComparator: (item1, item2) =>
              (item1.id ?? '').compareTo(item2.id ?? ''),
          order: GroupedListOrder.DESC,
          useStickyGroupSeparators: true,
          groupSeparatorBuilder: (DateTime value) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              (value.compareTo(DateTime.now()) == 0)
                  ? 'Today'
                  : (value.compareTo(
                              DateTime.now().add(const Duration(days: 1))) ==
                          0)
                      ? 'Tormorrow'
                      : value.dateDisplayFormat(),
              textAlign: TextAlign.center,
              style: CustomTextStyles.title1,
            ),
          ),
          itemBuilder: (context, task) {
            return Dismissible(
              onDismissed: (direction) => _onItemSwipe(task),
              key: Key(task.id ?? ''),
              background: Container(color: CustomColors.errorColor),
              child: TaskItemWidget(task: task),
            );
          },
        ),
      ),
      error: (error, stackTrace) => Text(error.toString()),
      loading: () => const Loading(),
    );
  }
}
