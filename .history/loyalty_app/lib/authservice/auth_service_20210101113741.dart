import 'dart:html';

import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;

const apiUrl = "http://13.65.26.62/app_dev.php/api";

class AuthService {
  static final SESSION = FlutterSession();

  Future<dynamic> register(String email, String password) async {
    try {
      var res = await http.post('$apiUrl/customer/login_check',
          body: {'email': email, 'password': password});
      return res?.body;
    } finally {
      print("hello");
    }
  }
}
