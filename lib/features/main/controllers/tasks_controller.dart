import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../constants/constants.dart';
import '../models/task_list_model.dart';
import '../repositories/main_repository.dart';

class TasksController extends StateNotifier<AsyncValue<TaskList>> {
  final Ref ref;

  TasksController(this.ref) : super(AsyncData(TaskList())) {
    getTaskList();
  }

  Future<void> getTaskList(
      {int offset = 0, int limit = 10, String status = taskStatusTodo}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
        () => MainRepository(ref: ref).getTaskList(offset, limit, status));
  }

  Future<void> deleteTask(Task task) async {
    try {
      if (state.value?.tasks?.any((element) => element.id == task.id) ??
          false) {
        state.value?.tasks?.removeWhere((element) => element.id == task.id);
        state = AsyncValue.data(state.value ?? TaskList());
      } else {
        state = AsyncError('Not have data in list', StackTrace.current);
      }
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}

final tasksControllerProvider =
    StateNotifierProvider<TasksController, AsyncValue<TaskList>>(
        (ref) => TasksController(ref));
