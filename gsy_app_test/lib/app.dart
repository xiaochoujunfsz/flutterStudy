import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gsy_app_test/common/event/http_error_event.dart';
import 'package:gsy_app_test/common/event/index.dart';
import 'package:gsy_app_test/common/localization/default_localizations.dart';
import 'package:gsy_app_test/common/net/code.dart';

class FlutterReduxApp extends StatefulWidget {
  const FlutterReduxApp({Key? key}) : super(key: key);

  @override
  State<FlutterReduxApp> createState() => _FlutterReduxAppState();
}

class _FlutterReduxAppState extends State<FlutterReduxApp> {
  final store = Store()
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

mixin HttpErrorListener on State<FlutterReduxApp> {
  StreamSubscription? stream;

  late BuildContext _context;

  @override
  void initState() {
    super.initState();

    stream = eventBus.on<HttpErrorEvent>().listen((event) {
      errorHandleFunction(event.code, event.message);
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (stream != null) {
      stream!.cancel();
      stream = null;
    }
  }

  //网络错误提醒
  errorHandleFunction(int? code, message) {
    switch (code) {
      case Code.NETWORK_ERROR:
        showToast(BaseLocalizations.i18n(_context)!.network_error);
        break;
      case 401:
        showToast(BaseLocalizations.i18n(_context)!.network_error_401);
        break;
      case 403:
        showToast(BaseLocalizations.i18n(_context)!.network_error_403);
        break;
      case 404:
        showToast(BaseLocalizations.i18n(_context)!.network_error_404);
        break;
      case 422:
        showToast(BaseLocalizations.i18n(_context)!.network_error_422);
        break;
      case Code.NETWORK_TIMEOUT:
        showToast(BaseLocalizations.i18n(_context)!.network_error_timeout);
        break;
      case Code.GITHUB_API_REFUSED:
        showToast(BaseLocalizations.i18n(_context)!.github_refused);
        break;
      default:
        showToast(
            "${BaseLocalizations.i18n(_context)!.network_error_unknown} $message");
        break;
    }
  }

  showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_LONG);
  }
}
