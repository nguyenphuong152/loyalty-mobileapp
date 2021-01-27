import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:loyalty_app/mixins/validator_mixin.dart';
import 'package:loyalty_app/src/services/auth_service.dart';
import 'package:loyalty_app/view/home/home_screen.dart';
import 'package:rxdart/rxdart.dart';

class AuthenBloc with ValidationMixin {
  final _email = new BehaviorSubject<String>();
  final _password = new BehaviorSubject<String>();
  final _errorMessage = new BehaviorSubject<String>();
  static final SESSION = FlutterSession();

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
      AuthService.setToken(data['token'], data['refresh_token']);
      var decodedData = this.decodeToken(AuthService.getToken());
      print(decodedData);
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) {
      //       return HomeScreen();
      //     },
      //   ),
      // );
      return data;
    } else {
      print("error \n");
    }
  }

  decodeToken(token) {
    try {
      return JwtDecoder.decode(token);
    } catch (err) {
      return null;
    }
  }

  dynamic getLoggedUserId() {
    var decodedData = this.decodeToken(AuthService.getToken());
    return decodedData;
  }

  // close streams
  dispose() {
    _email.close();
    _password.close();
    _errorMessage.close();
  }
}
