import 'package:flutter/material.dart';
import 'package:loyalty_app/component/text_field_container.dart';
import 'package:loyalty_app/constant.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController textController;
  const RoundedPasswordField({
    Key key,
    this.onChanged,
    this.textController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        onChanged: onChanged,
        cursorColor: mPrimaryColor,
        controller: textController,
        decoration: InputDecoration(
          hintText: "Mật khẩu",
          icon: Icon(
            Icons.lock,
            color: mPrimaryColor,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: mPrimaryColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
