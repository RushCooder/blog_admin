import 'dart:convert';

import 'package:blog_admin/constants/urls.dart';
import 'package:blog_admin/models/user_model.dart';
import 'package:http/http.dart' as http;

import '../utils/share_pref.dart';

class AuthApi {
  static Future<UserModel?> login(String email, String password) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('POST', Uri.parse('${baseUrl}login'));
    request.body = json.encode({"email": email, "password": password});
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var encodedData = await response.stream.bytesToString();
        var json = jsonDecode(encodedData);

        UserModel userModel = UserModel.fromJson(json);

        print('token: ${userModel.data!.token}');

        return userModel;
      } else {
        throw Error();
      }
    } catch (error) {
      print('auth api: $error');
      return null;
    }
  }

  static logout() async {
    try {
      String? token = await SharePref.getToken();
      var headers = {
        'Authorization': 'Bearer $token',
      };
      var request = http.Request('POST', Uri.parse('${baseUrl}logout'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        await SharePref.setToken('');
        print(await response.stream.bytesToString());
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (error) {
      print('logout error: $error');
    }
  }
}
