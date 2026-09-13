import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/models/user_model.dart';

class AuthController {
  static String? token;
  static UserModel? userData;

  static Future saveUserData(UserModel model, String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString('token', token);
    sharedPreferences.setString('user_data', jsonEncode(model.toJson()));

    token = token;
    userData = model;
  }

  static Future getUserData(UserModel model, String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String? user = sharedPreferences.getString('user_data');

    if (user != null) {
      userData = UserModel.fromJson(jsonDecode(user));
    }
  }
}
