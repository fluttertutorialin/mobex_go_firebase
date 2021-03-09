import 'dart:io';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class UserState {
  final String id,
      userName,
      mobile;
  final File userPhoto;
  final bool isLogin;

  UserState(
      {@required this.id,
      @required this.userName,
      @required this.mobile,
      this.userPhoto,
      @required this.isLogin});

  factory UserState.initial() {
    return UserState(
        id: "",
        userName: "",
        mobile: "",
        userPhoto: null,
        isLogin: false);
  }

  UserState copyWith(
      {String id,
      String userName,
      String mobile,
        File userPhoto,
      bool isLogin}) {
    return UserState(
        id: id ?? this.id,
        userName: userName ?? this.userName,
        mobile: mobile ?? this.mobile,
        userPhoto: userPhoto ?? this.userPhoto,
        isLogin: isLogin ?? this.isLogin);
  }
}
