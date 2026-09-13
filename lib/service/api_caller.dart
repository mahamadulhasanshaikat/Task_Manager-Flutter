import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:task_manager/controller/auth_controller.dart';

import '../models/api_response.dart';

class ApiCaller {
  static Future<ApiResponse> getRequest({required String url}) async {
    Response response = await get(
      Uri.parse(url),
      headers: {'token': AuthController.userToken ?? ''},
    );

    log('URL===$url');
    log('URL===${response.body}');

    if (response.statusCode == 200) {
      return ApiResponse(
        responseCode: response.statusCode,
        responseData: jsonDecode(response.body),
        isSuccess: true,
      );
    } else {
      return ApiResponse(
        responseCode: response.statusCode,
        responseData: jsonDecode(response.body),
        isSuccess: jsonDecode(response.body),
      );
    }
  }

  static Future<ApiResponse> postRequest({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    Response response = await post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'token': AuthController.userToken ?? '',
      },

      body: body != null ? jsonEncode(body) : null,
    );

    log('URL===$url');
    log('URL===${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      return ApiResponse(
        responseCode: response.statusCode,
        responseData: jsonDecode(response.body),
        isSuccess: true,
      );
    } else {
      return ApiResponse(
        responseCode: response.statusCode,
        responseData: jsonDecode(response.body),
        isSuccess: jsonDecode(response.body),
      );
    }
  }
}
