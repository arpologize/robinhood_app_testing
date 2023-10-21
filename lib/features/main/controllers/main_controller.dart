import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:robinhood_app_testing/constants/constants.dart';
import 'package:robinhood_app_testing/features/main/controllers/tasks_controller.dart';

enum TaskStatus { todo, doing, done }

class MainPageController extends ChangeNotifier {
  MainPageController(this.ref) : super();

  final Ref? ref;

  TaskStatus _taskStatus = TaskStatus.todo;
  TaskStatus get taskStatus => _taskStatus;

  String get taskStatusText => _taskStatus == TaskStatus.doing
      ? taskStatusDoing
      : _taskStatus == TaskStatus.done
          ? taskStatusDone
          : taskStatusTodo;

  void setTaskStatus(TaskStatus taskStatus) {
    _taskStatus = taskStatus;
    if (ref != null) {
      ref!
          .read(tasksControllerProvider.notifier)
          .getTaskList(offset: 0, status: taskStatusText);
    }
    notifyListeners();
  }
}

final mainPageControllerProvider = ChangeNotifierProvider<MainPageController>(
    (ref) => MainPageController(ref));
