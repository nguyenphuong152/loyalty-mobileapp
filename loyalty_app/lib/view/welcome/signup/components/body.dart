import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loyalty_app/component/already_have_account_check.dart';
import 'package:loyalty_app/component/rounded_input_field.dart';
import 'package:loyalty_app/component/rounded_password_field.dart';
import 'package:loyalty_app/view/welcome/login/login_screen.dart';
import 'package:loyalty_app/view/welcome/signup/components/background.dart';
import 'package:loyalty_app/view/welcome/signup/components/or_divider.dart';
import 'package:loyalty_app/view/welcome/signup/components/social_icon.dart';

import '../../../../constant.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              "assets/images/signup.svg",
              height: size.height * 0.35,
            ),
            RoundedInputField(
              hintText: "Email",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              onChanged: (value) {},
            ),
            SizedBox(
              width: 200,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: mPrimaryColor)),
                color: mPrimaryColor,
                textColor: Colors.white,
                onPressed: () {},
                child: Text(
                  "Đăng kí",
                  style: TextStyle(fontSize: body, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocalIcon(
                  iconSrc: "assets/icons/facebook.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/google-plus.svg",
                  press: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
