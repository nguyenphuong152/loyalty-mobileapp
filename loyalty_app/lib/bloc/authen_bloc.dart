import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:loyalty_app/mixins/validator_mixin.dart';
import 'package:loyalty_app/models/customer_model.dart';
import 'package:loyalty_app/src/services/auth_service.dart';
import 'package:loyalty_app/src/services/repository.dart';
import 'package:loyalty_app/view/home/home_screen.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  dynamic login(BuildContext context) async {
    var authInfo = AuthService();
    final _repository = Repository();

    //final res = await authInfo.login(_email.value, _password.value);
    final res = await authInfo.login("user@oloy.com", "loyalty");

    //CustomerModel customerModel = await _repository.fetchCustomerData();

    final data = jsonDecode(res) as Map<String, dynamic>;
    if (data.isNotEmpty) {
      AuthService.setToken(data['token'], data['refresh_token']);
      final decodedToken = decodeToken(data['token']) as Map<String, dynamic>;
      //save token and customerId into sharedPreferences
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('token', data['token']);
      prefs.setString('customerId', decodedToken['id']);
      // prefs.setString(
      //     'name', customerModel.lastName + " " + customerModel.firstName);
      // prefs.setString('email', customerModel.email);
      // prefs.setString('phone', customerModel.phone);
      // prefs.setString('loyaltyCardNumber', customerModel.loyaltyCardNumber);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return HomeScreen();
          },
        ),
      );
      return data;
    } else {
      print("error \n");
    }
  }

  decodeToken(String token) {
    return JwtDecoder.decode(token);
  }

  // close streams
  dispose() {
    _email.close();
    _password.close();
    _errorMessage.close();
  }
}
