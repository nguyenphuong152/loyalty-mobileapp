import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final baseUrl = 'http://13.65.26.62/app_dev.php/api';

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

      return res;
    } finally {}
  }
}
