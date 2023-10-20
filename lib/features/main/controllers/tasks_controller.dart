import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/task_list_model.dart';
import '../repositories/main_repository.dart';

class TasksController extends StateNotifier<AsyncValue<TaskList>> {
  final Ref ref;

  TasksController(this.ref) : super(AsyncData(TaskList())) {
    getTaskList();
  }

  Future<void> getTaskList() async {
    state = const AsyncValue.loading();
    state =
        await AsyncValue.guard(() => MainRepository(ref: ref).getTaskList());
  }
}

final tasksControllerProvider =
    StateNotifierProvider<TasksController, AsyncValue<TaskList>>(
        (ref) => TasksController(ref));
