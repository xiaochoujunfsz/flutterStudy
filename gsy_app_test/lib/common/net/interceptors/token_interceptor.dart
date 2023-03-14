import 'package:dio/dio.dart';

//token拦截器
class TokenInterceptors extends InterceptorsWrapper {
  String? _token;

  @override
  onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    //授权码
    if (_token == null) {
      var authorizationCode = await ge
    }
    return super.onRequest(options, handler);
  }

  //获取授权token
  getAuthorization() async {
    String? token = await
  }
}