import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loyalty_app/constant.dart';
import 'package:loyalty_app/view/account_info/account_info_screen.dart';
import 'package:loyalty_app/view/maintenance_booking_management/MaintenanceBookingManagement.dart';

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
          dense: true,
          leading: FaIcon(
            FontAwesomeIcons.user,
            size: 18,
          ),
          title: Text('Thông tin tài khoản',
              style: TextStyle(fontSize: mFontSize)),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return AccountInfoScreen();
                },
              ),
            );
          },
        ),
        ListTile(
          dense: true,
          leading: FaIcon(
            FontAwesomeIcons.cogs,
            size: 18,
          ),
          title: Text('Thông tin đăng ký bảo hành',
              style: TextStyle(fontSize: mFontSize)),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return MaintenanceBookingManagementScreen();
                },
              ),
            );
          },
        ),
        ListTile(
          dense: true,
          leading: FaIcon(
            FontAwesomeIcons.questionCircle,
            size: 18,
          ),
          title: Text('Hướng dẫn', style: TextStyle(fontSize: mFontSize)),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          dense: true,
          leading: FaIcon(
            FontAwesomeIcons.slidersH,
            size: 18,
          ),
          title: Text('Cài đặt', style: TextStyle(fontSize: mFontSize)),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          dense: true,
          leading: FaIcon(
            FontAwesomeIcons.signOutAlt,
            size: 18,
          ),
          title: Text('Đăng xuất', style: TextStyle(fontSize: mFontSize)),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
