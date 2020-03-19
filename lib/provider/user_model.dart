import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fskymusic/application.dart';
import 'package:fskymusic/model/user.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:fskymusic/utils/net_utils.dart';
import 'package:fskymusic/utils/utils.dart';

class UserModel with ChangeNotifier {
  User _user;
  User get user => _user;

  void initUser() {
    if (Application.sp.containsKey('user')) {
      String s = Application.sp.getString('user');
      _user = User.fromJson(json.decode(s));
    }
  }

  Future<User> login(BuildContext context, String phone, String pwd) async {
    User user = await NetUtils.login(context, phone, pwd);
    _saveUserInfo(user);
    return user;
  }

  _saveUserInfo(User user) {
    _user = user;
    Application.sp.setString('user', json.encode(user.toJson()));
  }
}
