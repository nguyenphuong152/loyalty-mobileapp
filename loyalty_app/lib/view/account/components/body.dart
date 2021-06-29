import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loyalty_app/constant.dart';
import 'package:loyalty_app/view/account_info/account_info_screen.dart';
import 'package:loyalty_app/view/booking_management/MaintenanceBookingManagement.dart';
import 'package:loyalty_app/view/booking_management/WarrantyBookingScreen.dart';
import 'package:loyalty_app/view/support_request/support_request_screen.dart';
import 'package:loyalty_app/view/account/components/test.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      // padding: EdgeInsets.only(top: space_height),
      children: <Widget>[
        ListTile(
          dense: true,
          leading: FaIcon(
            FontAwesomeIcons.user,
            size: footnote,
          ),
          visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          title: Transform.translate(
            offset: Offset(-16, 0),
            child: Text('Thông tin tài khoản',
                style: TextStyle(fontSize: footnote)),
          ),
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
        Divider(),
        ListTile(
          dense: true,
          leading: FaIcon(
            FontAwesomeIcons.cogs,
            size: footnote,
          ),
          visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          title: Transform.translate(
            offset: Offset(-16, 0),
            child: Text('Thông tin đăng ký bảo trì',
                style: TextStyle(fontSize: footnote)),
          ),
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
        Divider(),
        ListTile(
          dense: true,
          leading: FaIcon(
            FontAwesomeIcons.briefcase,
            size: footnote,
          ),
          visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          title: Transform.translate(
            offset: Offset(-16, 0),
            child: Text('Thông tin đăng ký bảo hành',
                style: TextStyle(fontSize: footnote)),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return WarrantyBookingManagement();
                },
              ),
            );
          },
        ),
        Divider(),
        ListTile(
          dense: true,
          leading: FaIcon(
            FontAwesomeIcons.mailBulk,
            size: footnote,
          ),
          visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          title: Transform.translate(
            offset: Offset(-16, 0),
            child: Text('Hộp thư góp ý', style: TextStyle(fontSize: footnote)),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return SupportRequestScreen();
                },
              ),
            );
          },
        ),
        Divider(),
        ListTile(
          dense: true,
          leading: FaIcon(
            FontAwesomeIcons.questionCircle,
            size: footnote,
          ),
          visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          title: Transform.translate(
            offset: Offset(-16, 0),
            child: Text('Hướng dẫn', style: TextStyle(fontSize: footnote)),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        Divider(),
        ListTile(
          dense: true,
          leading: FaIcon(
            FontAwesomeIcons.slidersH,
            size: footnote,
          ),
          visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          title: Transform.translate(
            offset: Offset(-16, 0),
            child: Text('Cài đặt', style: TextStyle(fontSize: footnote)),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        Divider(),
        ListTile(
          dense: true,
          leading: FaIcon(
            FontAwesomeIcons.signOutAlt,
            size: footnote,
          ),
          visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          title: Transform.translate(
            offset: Offset(-16, 0),
            child: Text('Đăng xuất', style: TextStyle(fontSize: footnote)),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        Divider(),
      ],
    );
  }
}
