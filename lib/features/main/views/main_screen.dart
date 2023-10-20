import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:robinhood_app_testing/config/themes/themes.dart';
import 'package:robinhood_app_testing/features/main/components/task_status_widget.dart';
import 'package:robinhood_app_testing/features/main/controllers/main_controller.dart';
import 'package:robinhood_app_testing/features/main/controllers/tasks_controller.dart';
import 'package:robinhood_app_testing/features/main/models/task_list_model.dart';
import 'package:robinhood_app_testing/shared_components/loading.dart';
import 'package:robinhood_app_testing/utils/extension/extension.dart';

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

  void _onItemSwipe(Task task) {
    ref.read(tasksControllerProvider.notifier).deleteTask(task);
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
          itemBuilder: (context, element) {
            return Dismissible(
              onDismissed: (direction) => _onItemSwipe(element),
              key: Key(element.id ?? ''),
              child: Card(
                elevation: 8.0,
                margin:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                child: SizedBox(
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    leading: const Icon(Icons.account_circle),
                    title: Text(
                      element.title ?? '',
                      style: CustomTextStyles.subTitle1,
                    ),
                    trailing: const Icon(Icons.arrow_forward),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      error: (error, stackTrace) => Text(error.toString()),
      loading: () => const Loading(),
    );
  }
}
