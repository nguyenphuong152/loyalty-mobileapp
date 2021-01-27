import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      children: <Widget>[
        ListTile(
          dense: true,
          leading: FaIcon(
            FontAwesomeIcons.user,
            size: 18,
          ),
          title: Text('song thị méo'.toUpperCase(),
              style: TextStyle(fontSize: 14)),
        ),
        ListTile(
          dense: true,
          leading: FaIcon(
            FontAwesomeIcons.venusMars,
            size: 18,
          ),
          title: Text('Cái', style: TextStyle(fontSize: 14)),
        ),
        ListTile(
          dense: true,
          leading: FaIcon(
            FontAwesomeIcons.birthdayCake,
            size: 18,
          ),
          title: Text('26/05/2018', style: TextStyle(fontSize: 14)),
        ),
        ListTile(
          dense: true,
          leading: FaIcon(
            FontAwesomeIcons.flag,
            size: 18,
          ),
          title: Text('viet nam'.toUpperCase(), style: TextStyle(fontSize: 14)),
        ),
        ListTile(
          dense: true,
          leading: FaIcon(
            FontAwesomeIcons.idCard,
            size: 18,
          ),
          title: Text('1234555577', style: TextStyle(fontSize: 14)),
        ),
        ListTile(
          dense: true,
          leading: FaIcon(
            FontAwesomeIcons.phone,
            size: 18,
          ),
          title: Text('1900068887', style: TextStyle(fontSize: 14)),
        ),
        ListTile(
          dense: true,
          leading: FaIcon(
            FontAwesomeIcons.envelope,
            size: 18,
          ),
          title: Text('meomeo@gmail.com', style: TextStyle(fontSize: 14)),
        ),
        ListTile(
          leading: FaIcon(
            FontAwesomeIcons.mapMarkerAlt,
            size: 18,
          ),
          title: Text('KTX khu B, ĐHQG', style: TextStyle(fontSize: 14)),
        ),
      ],
    );
  }
}
