import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/models/user_model.dart';

class AuthController {
  static String? userToken;
  static UserModel? userData;

  static Future<void> saveUserData(UserModel model, String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences.setString('token', token);
    await sharedPreferences.setString('user_data', jsonEncode(model.toJson()));

    userToken = token;
    userData = model;
  }

  static Future<void> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String? token = sharedPreferences.getString('token');

    if (token != null) {
      userToken = token;
    }

    String? user = sharedPreferences.getString('user_data');

    if (user != null) {
      userData = UserModel.fromJson(jsonDecode(user));
    }
  }

  static Future<bool> isUserLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String? token = sharedPreferences.getString('token');

    return token != null;
  }

  // লগআউটের সময় লোকাল ডাটা ক্লিয়ার করার মেথড
  static Future<void> clearUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    userToken = null;
    userData = null;
  }
}