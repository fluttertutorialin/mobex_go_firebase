import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  SharedPreferences pref;

  void saveUserName(username) {
    dispatch(SaveUserName(username: username));
  }

  void saveMobile(mobile) {
    dispatch(SaveMobile(mobile: mobile));
  }

  void saveId(id) {
    dispatch(SaveId(id: id));
  }

  void saveIsLogin(isLogin) {
    dispatch(SaveIsLogin(isLogin: isLogin));
  }

  void getLoginDetails() {
    dispatch(GetLoginDetails());
  }

  @override
  UserState get initialState => UserState.initial();

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {

    if (event is SaveUserName) {
      pref = await SharedPreferences.getInstance();
      pref.setString("username", event.username);
    }

    if (event is SaveMobile) {
      pref = await SharedPreferences.getInstance();
      pref.setString("mobile", event.mobile);
    }

    if (event is SaveId) {
      pref = await SharedPreferences.getInstance();
      pref.setString("id", event.id);
    }

    if (event is SaveIsLogin) {
      pref = await SharedPreferences.getInstance();
      pref.setBool("isLogin", event.isLogin);
    }

    //GET LOGIN DETAILS
    if (event is GetLoginDetails) {
      pref = await SharedPreferences.getInstance();
      yield currentState.copyWith(
          mobile: pref.getString('mobile'),
          userName: pref.getString('username'),
          id: pref.getString('id'),
          isLogin: pref.getBool('isLogin'));
    }
  }
}
