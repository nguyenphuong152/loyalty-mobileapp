import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loyalty_app/bloc/authen_bloc.dart';
import 'package:loyalty_app/component/already_have_account_check.dart';
import 'package:loyalty_app/component/rounded_input_field.dart';
import 'package:loyalty_app/component/rounded_password_field.dart';
import 'package:loyalty_app/view/welcome/signup/signup_screen.dart';
import 'package:loyalty_app/view/welcome/welcomee/components/background.dart';

import '../../../../constant.dart';

class Body extends StatelessWidget {
  final authen = new AuthenBloc();
  Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              "assets/images/login.svg",
              height: size.height * 0.3,
            ),
            SizedBox(height: size.height * 0.03),
            StreamBuilder<String>(
                stream: authen.email,
                builder: (context, snapshot) {
                  return RoundedInputField(
                    hintText: "Email",
                    onChanged: authen.changeEmail,
                    textController:
                        TextEditingController(text: "user-1@oloy.com"),
                  );
                }),
            StreamBuilder<String>(
                stream: authen.password,
                builder: (context, snapshot) {
                  return RoundedPasswordField(
                    onChanged: authen.changePassword,
                    textController: TextEditingController(text: "loyalty"),
                  );
                }),
            SizedBox(height: size.height * 0.03),
            SizedBox(
              width: 200,
              child: StreamBuilder<bool>(
                  stream: authen.submitValidForm,
                  builder: (context, snapshot) {
                    return RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: mPrimaryColor)),
                      color: mPrimaryColor,
                      textColor: Colors.white,
                      onPressed: () {
                        if (snapshot.hasError) {
                          print(snapshot.error);
                          return null;
                        }
                        authen.login(context);
                      },
                      child: Text(
                        "đăng nhập".toUpperCase(),
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w400),
                      ),
                    );
                  }),
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
