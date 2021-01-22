import 'dart:convert';

import 'package:loyalty_app/src/services/auth_service.dart';
import 'package:rxdart/rxdart.dart';

class AuthenBloc {
  final _email = new BehaviorSubject<String>();
  final _password = new BehaviorSubject<String>();
  final _errorMessage = new BehaviorSubject<String>();

  var authInfo;

  dynamic login(BuildContext context) async {
    authInfo = AuthService();

    final res = await authInfo.login(_email.value, _password.value);
    final data = jsonDecode(res) as Map<String, dynamic>;

    if (data['status'] != 200) {
      print("vo if");
    } else {
      print("vo else");
    }
  }
}
