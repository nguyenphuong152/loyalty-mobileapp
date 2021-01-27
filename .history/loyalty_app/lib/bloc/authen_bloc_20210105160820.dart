import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loyalty_app/mixins/validator_mixin.dart';
import 'package:loyalty_app/src/services/auth_service.dart';
import 'package:loyalty_app/view/home/home_screen.dart';
import 'package:rxdart/rxdart.dart';

class AuthenBloc with ValidationMixin {
  final _email = new BehaviorSubject<String>();
  final _password = new BehaviorSubject<String>();
  final _errorMessage = new BehaviorSubject<String>();

  // getters: Changers
  Function(String) get changeEmail {
    addError(null);
    return _email.sink.add;
  }

  Function(String) get changePassword {
    addError(null);
    return _password.sink.add;
  }

  Function(String) get addError => _errorMessage.sink.add;
  Stream<String> get email => _email.stream.transform(validatorEmail);
  Stream<String> get password => _password.stream.transform(validatorPassword);
  Stream<String> get errorMessage => _errorMessage.stream;

  Stream<bool> get submitValidForm => Rx.combineLatest3(
        email,
        password,
        errorMessage,
        (e, p, er) => true,
      );

  var authInfo;

  dynamic login(BuildContext context) async {
    authInfo = AuthService();

    final res = await authInfo.login(_email.value, _password.value);
    final data = jsonDecode(res) as Map<String, dynamic>;
    if (data.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return HomeScreen();
          },
        ),
      );
    } else {
      print("loi \n");
    }
  }

  // close streams
  dispose() {
    _email.close();
    _password.close();
    _errorMessage.close();
  }
}
