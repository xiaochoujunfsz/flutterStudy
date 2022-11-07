import 'dart:collection';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app2/HttpError.dart';

typedef HttpSuccessCallback = void Function(String data);
typedef HttpFailureCallback = void Function(HttpError error);

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
      //全局属性：请求前缀、连接超时时间、响应超时时间
      BaseOptions options = BaseOptions(
        connectTimeout: CONNECT_TIMEOUT,
        receiveTimeout: RECEIVE_TIMEOUT,
      );
      _client = Dio(options);
    }
  }

  ///初始化公共属性
  ///[baseUrl] 地址前缀
  ///[connectTimeout] 连接超时时间
  ///[receiveTimeout] 接收超时时间
  ///[interceptors] 基础拦截器
  void init(
      {String? baseUrl,
      int? connectTimeout,
      int? receiveTimeout,
      List<Interceptor>? interceptors}) {
    _client?.options = _client!.options.copyWith(
      baseUrl: baseUrl,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
    );
    if (interceptors != null && interceptors.isNotEmpty) {
      _client!.interceptors.addAll(interceptors);
    }
  }

  ///统一网络请求
  ///[url] 网络请求地址不包含域名
  ///[data] post 请求参数
  ///[params] url请求参数支持restful
  ///[options] 请求配置
  ///[successCallback] 请求成功回调
  ///[errorCallback] 请求失败回调
  ///[tag] 请求统一标识，用于取消网络请求
  void _request({
    required String url,
    String? method,
    data,
    Map<String, dynamic>? params,
    Options? options,
    required HttpSuccessCallback successCallback,
    required HttpFailureCallback errorCallback,
    required String tag,
  }) async {
    //检查网络是否连接
    ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      if (errorCallback != null) {
        errorCallback(HttpError(HttpError.NETWORK_ERROR, "网络异常，请稍后重试！"));
      }
      return;
    }
    //设置默认值
    params = params ?? {};
    method = method ?? 'GET';
    options?.method = method;
    options = options ?? Options(method: method);
    //请求头
    options.headers = await _headers();
    try {
      CancelToken cancelToken = (_cancelTokens[tag] ?? CancelToken());
      _cancelTokens[tag] = cancelToken;
      Response response = await _client!.request(url,
          data: data,
          queryParameters: params,
          options: options,
          cancelToken: cancelToken);
      var _responseData = response.data;
      print("响应的数据：$_responseData");
      int statusCode = _responseData["code"];
      if (statusCode == 200) {
        //成功
        successCallback(_responseData["data"]);
      } else {
        String message = _responseData["msg"].toString();
        errorCallback(HttpError("$statusCode", message));
      }
    } on DioError catch (e, s) {
      if (e.type != DioErrorType.cancel) {
        errorCallback(HttpError.dioError(e));
      }
    } catch (e, s) {
      errorCallback(HttpError(HttpError.UNKNOWN, "未知错误，请稍后重试！"));
    }
  }

  //取消网络请求
  void cancel(String tag) {
    print("取消网络请求前，cancelToken集合$_cancelTokens");
    if (_cancelTokens.containsKey(tag)) {
      if (!_cancelTokens[tag]!.isCancelled) {
        _cancelTokens[tag]!.cancel();
      }
      _cancelTokens.remove(tag);
      print("取消网络请求后，cancelToken集合$_cancelTokens");
    }
  }

  //请求头
  Future<Map<String, String>> _headers() async {
    Map<String, String> headers = HashMap();
    String token = '';
    headers.addAll({"token": token});
    return headers;
  }

  ///Get网络请求
  ///[url] 网络请求地址不包含域名
  ///[params] url请求参数支持restful
  ///[options] 请求配置
  ///[successCallback] 请求成功回调
  ///[errorCallback] 请求失败回调
  ///[tag] 请求统一标识，用于取消网络请求
  get({
    required String url,
    required Map<String, dynamic> params,
    Options? options,
    required HttpSuccessCallback successCallback,
    required HttpFailureCallback errorCallback,
    required String tag,
  }) async {
    return _request(
      url: url,
      params: params,
      method: "get",
      options: options,
      successCallback: successCallback,
      errorCallback: errorCallback,
      tag: tag,
    );
  }

  ///post网络请求
  ///[url] 网络请求地址不包含域名
  ///[data] post 请求参数
  ///[params] url请求参数支持restful
  ///[options] 请求配置
  ///[successCallback] 请求成功回调
  ///[errorCallback] 请求失败回调
  ///[tag] 请求统一标识，用于取消网络请求
  post({
    required String url,
    data,
    Map<String, dynamic>? params,
    Options? options,
    required HttpSuccessCallback successCallback,
    required HttpFailureCallback errorCallback,
    required String tag,
  }) async {
    _request(
      url: url,
      data: data,
      method: "post",
      params: params,
      options: options,
      successCallback: successCallback,
      errorCallback: errorCallback,
      tag: tag,
    );
  }
}
