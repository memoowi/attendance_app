import 'dart:convert';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:attendance_app/models/token_model.dart';
import 'package:attendance_app/models/user_model.dart';
import 'package:attendance_app/utils/config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthProvider extends ChangeNotifier {
  final dio = Dio();
  String? _token;
  String? _validationMessage;
  UserModel? _user;

  String? get token => _token;
  String? get validationMessage => _validationMessage;
  UserModel? get user => _user;

  Future<void> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
    notifyListeners();
  }

  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
    if (_token != null) {
      try {
        final response = await dio.get(Config.userApiUrl,
            options: Options(headers: {
              'Authorization': 'Bearer $_token',
            }));
        if (response.statusCode == 200) {
          _user = UserModel.fromJson(response.data);
          return true;
        } else {
          _token = null;
          prefs.remove('token');
          notifyListeners();
          return false;
        }
      } catch (e) {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> login(String email, String password, BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse(Config.loginApiUrl),
        body: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        _validationMessage = null;
        _token = TokenModel.fromJson(jsonDecode(response.body)).token!;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', _token!);
        await isLoggedIn();
        AnimatedSnackBar.material('Login successful', type: AnimatedSnackBarType.success).show(context);
        notifyListeners();
        return true;
      } else if (response.statusCode == 401) {
        _validationMessage =
            TokenModel.fromJson(jsonDecode(response.body)).message!;
        notifyListeners();
        return false;
      } else {
        _validationMessage = 'Failed to login';
        notifyListeners();
        return false;
      }
    } catch (e) {
      _validationMessage = 'Failed to login. Please try again.';
      notifyListeners();
      return false;
    }
  }

  Future<void> logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final response = await dio.post(
        Config.logoutApiUrl,
        options: Options(headers: {
          'Authorization': 'Bearer $_token',
        }),
      );
      if (response.statusCode == 200) {
        String message = TokenModel.fromJson(response.data).message!;
        AnimatedSnackBar.material(message, type: AnimatedSnackBarType.success).show(context);
        _user = null;
        _token = null;
        prefs.remove('token');
        notifyListeners();
      } else {
        throw Exception('Failed to logout');
      }
    } catch (e) {
      rethrow;
    }
  }
}
