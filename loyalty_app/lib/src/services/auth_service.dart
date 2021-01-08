import 'dart:io';

import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;
import 'package:loyalty_app/constant.dart';

class AuthService {
  // final baseUrl = ;

  static final SESSION = FlutterSession();

  Future<dynamic> login(String email, String password) async {
    print("user: " + email + "\n");
    print("pass: " + password + "\n");

    try {
      var res = await http.post(
        '$baseUrl/customer/login_check',
        body: {
          '_username': email,
          '_password': password,
        },
      );
      if (res.statusCode == 200) {
        return res.body;
      } else {
        return null;
      }
    } finally {}
  }

  static setToken(String token, String refreshToken) async {
    _AuthData data = _AuthData(token, refreshToken);
    await SESSION.set('tokens', data);
  }

  static Future<Map<String, dynamic>> getToken() async {
    return await SESSION.get('tokens');
  }

  static removeToken() async {
    await SESSION.prefs.clear();
  }
}

class _AuthData {
  String token, refreshToken;
  _AuthData(this.token, this.refreshToken);

  // toJson
  // required by Session lib
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['token'] = token;
    data['refresh_token'] = refreshToken;
    return data;
  }
}
