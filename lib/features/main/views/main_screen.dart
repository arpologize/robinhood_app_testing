import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:robinhood_app_testing/config/themes/custom_colors.dart';
import 'package:robinhood_app_testing/features/main/components/task_status_widget.dart';
import 'package:robinhood_app_testing/features/main/controllers/main_controller.dart';
import 'package:robinhood_app_testing/features/main/controllers/tasks_controller.dart';
import 'package:robinhood_app_testing/shared_components/loading.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({
    Key? key,
  }) : super(key: key);

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends ConsumerState<MainScreen> {
  void _onTaskStatusTap(TaskStatus taskStatus) {
    ref.read(mainPageControllerProvider).setTaskStatus(taskStatus);
  }

  @override
  Widget build(BuildContext context) {
    final pageController = ref.watch(mainPageControllerProvider);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: CustomColors.onBackgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildHeader(pageController),
                _buildTaskList(pageController)
              ],
            ),
          ),
        ));
  }

  Widget _buildHeader(MainPageController pageController) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TaskStatusWidget(
          name: 'To-do',
          isSelect: pageController.taskStatus == TaskStatus.todo,
          onTap: () => _onTaskStatusTap(TaskStatus.todo),
        ),
        TaskStatusWidget(
          name: 'Doing',
          isSelect: pageController.taskStatus == TaskStatus.doing,
          onTap: () => _onTaskStatusTap(TaskStatus.doing),
        ),
        TaskStatusWidget(
          name: 'Done',
          isSelect: pageController.taskStatus == TaskStatus.done,
          onTap: () => _onTaskStatusTap(TaskStatus.done),
        )
      ],
    );
  }

  Widget _buildTaskList(MainPageController pageController) {
    final taskList = ref.watch(tasksControllerProvider);
    return taskList.when(
      data: (taskData) => Column(
        mainAxisSize: MainAxisSize.min,
        children: (taskData.tasks
                    ?.where((element) =>
                        element.status == pageController.taskStatusText)
                    .toList() ??
                [])
            .asMap()
            .map((index, task) => MapEntry(
                  index,
                  Text(task.title ?? ''),
                ))
            .values
            .toList(),
      ),
      error: (error, stackTrace) => Text(error.toString()),
      loading: () => const Loading(),
    );
  }
}
