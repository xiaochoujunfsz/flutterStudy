import 'package:dio/dio.dart';

class HttpManager {
  //  存储网络请求的token，方便网络请求完成后取消网络请求
  Map<String, CancelToken> _cancelTokens = Map();

  //  超时时间
  static const int CONNECT_TIMEOUT = 30000;
  static const int RECEIVE_TIMEOUT = 30000;
  Dio? _client;

  static final HttpManager _instance = HttpManager._internal();

  factory HttpManager() => _instance;

  Dio get client => _client!;

  HttpManager._internal() {
    if (_client == null) {
      BaseOptions options = BaseOptions(
        connectTimeout: CONNECT_TIMEOUT,
        receiveTimeout: RECEIVE_TIMEOUT,
      );
      _client = Dio(options);
    }
  }
}
