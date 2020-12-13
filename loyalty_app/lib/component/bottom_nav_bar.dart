import 'package:loyalty_app/constant.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    Key key,
  }) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showUnselectedLabels: true,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.credit_card_outlined),
          label: 'Thẻ',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_view_day_outlined),
          label: 'Đặt lịch',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.support_agent_outlined),
          label: 'Hỗ trợ',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle_outlined),
          label: 'Tài khoản',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: mPrimaryColor,
      unselectedItemColor: Colors.grey,
      selectedFontSize: 13,
      onTap: _onItemTapped,
    );
  }
}
