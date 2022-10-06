import 'package:blog_admin/apis/auth_api.dart';
import 'package:blog_admin/models/user_model.dart';
import 'package:blog_admin/utils/share_pref.dart';
import 'package:flutter/material.dart';


class AuthProvider extends ChangeNotifier {
  bool isObscure = true;
  bool isVisible = false;
  String? email;
  String? password;
  String errorMessage = '';

  // change visibility of password
  void changeVisibility() {
    isVisible = !isVisible;
    isObscure = !isObscure;

    print('obscure: $isObscure');
    notifyListeners();
  }

  // set email from email field
  void setEmail(String email) {
    this.email = email;
  }

  // set password from password field
  void setPassword(String password) {
    this.password = password;
  }

  void setError(String err) {
    errorMessage = err;
    notifyListeners();
  }

  // login
  Future<bool> login(String email, String password) async {
    try{
      UserModel? userModel = await AuthApi.login(email, password);

      if (userModel != null) {
        await SharePref.setToken(userModel.data!.token!);
        return true;
      }
      throw Error();
    }
    catch(error){
      print('Error at auth: $error');
      return false;
    }
  }
  // login
  Future<void> logout() async {
    try{
      await AuthApi.logout();
    }
    catch(error){
      print('Error at auth: $error');
    }
  }
}
