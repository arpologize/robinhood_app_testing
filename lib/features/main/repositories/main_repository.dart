import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../utils/services/rest_api_service.dart';
import '../models/task_list_model.dart';

class MainRepository {
  final Ref ref;

  MainRepository({required this.ref});

  final _todoList = '/todo-list';

  Future<TaskList> getTaskList(int offset, int limit, String status) async {
    try {
      var res = await ref.watch(apiClientProvider).get(_todoList,
          queryParameters: {
            'offset': offset,
            'limit': limit,
            'status': status
          });
      return TaskList.fromJson(res.data);
    } on DioException catch (err) {
      if (err.response?.statusCode == 401) {
        throw '${err.response?.statusCode}';
      } else {
        throw '${err.response?.statusMessage}';
      }
    }
  }
}
