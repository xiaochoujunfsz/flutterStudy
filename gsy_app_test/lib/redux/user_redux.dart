import 'package:gsy_app_test/model/User.dart';
import 'package:gsy_app_test/redux/common_state.dart';
import 'package:gsy_app_test/redux/middleware/epic_store.dart';
import 'package:redux/redux.dart';

//combineReducers的作用是把action和函数绑定起来，免去了写例如if (action is UpdateUserAction)之类的判断语句，对应的action执行对应的函数。
final UserReducer = combineReducers<User?>([
  TypedReducer<User?, UpdateUserAction>(_updateLoaded),
]);

//如果有UpdateUserAction发起一个请求时，就会调用到_updateLoaded
User? _updateLoaded(User? user, action) {
  user = action.userInfo;
  return user;
}

//定义一个UpdateUserAction,用于发起userInfo的改变
class UpdateUserAction {
  final User? userInfo;

  UpdateUserAction(this.userInfo);
}

class FetchUserAction {}

class UserInfoMiddleware implements MiddlewareClass<CommonState> {
  @override
  call(Store<CommonState> store, action, NextDispatcher next) {
    if (action is UpdateUserAction) {
      print("*********** UserInfoMiddleware *********** ");
    }
    next(action);
  }
}

Stream<dynamic> userInfoEpic(Stream<dynamic> actions,EpicStore<CommonState> store) {
  Stream<dynamic> _loadUserInfo() async*{
    print("*********** userInfoEpic _loadUserInfo ***********");
    var res = await
  }
}
