import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loyalty_app/constant.dart';
import 'package:loyalty_app/view/account/account_screen.dart';
import 'package:loyalty_app/view/card/card_screen.dart';
import 'package:loyalty_app/view/points/point_screen.dart';
import 'package:loyalty_app/view/transaction/transaction_screen.dart';

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

  static List<Widget> _widgetOptions = <Widget>[
    CardScreen(),
    TransactionScreen(),
    PointScreen(),
    AccountScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(context),
      bottomNavigationBar: Container(
        height: 64,
        decoration: BoxDecoration(
            color: Colors.white10,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 15,
                  offset: Offset(0, 5))
            ],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24), topRight: Radius.circular(24))),
        child: BottomNavigationBar(
          showUnselectedLabels: true,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.credit_card_outlined),
              label: 'Thẻ',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.clock,
                size: 18,
              ),
              label: 'Lịch sử',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.star,
                size: 18,
              ),
              label: 'Điểm thưởng',
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
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
