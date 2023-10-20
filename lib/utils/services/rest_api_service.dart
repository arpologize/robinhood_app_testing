import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../constants/api_path.dart';

export 'package:dio/dio.dart';

class ApiInterceptor extends Interceptor {
  final Ref ref;

  ApiInterceptor({
    required this.ref,
  });

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    handler.reject(err);
  }
}

class ApiClient {
  Dio baseUrl(ProviderRef<Dio> ref) {
    Dio dio = Dio();
    dio.options.baseUrl = prod;
    dio.options.connectTimeout = const Duration(seconds: 5);
    dio.options.receiveTimeout = const Duration(seconds: 5);
    dio.interceptors.add(ApiInterceptor(ref: ref));
    return dio;
  }
}

final apiClientProvider = Provider<Dio>((ref) {
  return ApiClient().baseUrl(ref);
});
