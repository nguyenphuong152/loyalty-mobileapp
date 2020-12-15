import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.account_circle_outlined),
          title: Text('Thông tin tài khoản'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(Icons.store_outlined),
          title: Text('Danh sách cửa hàng'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(Icons.history_outlined),
          title: Text('Lịch sử điểm'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(Icons.help_outline_outlined),
          title: Text('Hướng dẫn'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(Icons.info_outline),
          title: Text('Giới thiệu'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(Icons.settings_applications_outlined),
          title: Text('Cài đặt'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text('Đăng xuất'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
