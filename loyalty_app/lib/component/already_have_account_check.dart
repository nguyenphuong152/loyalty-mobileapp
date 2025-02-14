import 'package:flutter/material.dart';
import 'package:loyalty_app/constant.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function press;
  const AlreadyHaveAnAccountCheck({
    Key key,
    this.login = true,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "Bạn chưa có tài khoản ? " : "Đã có tài khoản ? ",
          style: TextStyle(color: mPrimaryColor),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? "Đăng kí" : "Đăng nhập",
            style: TextStyle(
              color: mPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
