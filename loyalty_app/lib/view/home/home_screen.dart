import 'package:flutter/material.dart';
import 'package:loyalty_app/constant.dart';
import 'package:loyalty_app/view/Datepicker/datepicker_screen.dart';
import 'package:loyalty_app/view/account/account_screen.dart';
import 'package:loyalty_app/view/card/card_screen.dart';

import 'components/app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key key,
  }) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    CardScreen(),
    DatePickerScreen(),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
    AccountScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(context),
      bottomNavigationBar: BottomNavigationBar(
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
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
