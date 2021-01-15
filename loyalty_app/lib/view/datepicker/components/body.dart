import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:intl/intl.dart';
import 'package:loyalty_app/bloc/maintenance_booking_bloc.dart';
import 'package:loyalty_app/constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loyalty_app/view/card/card_screen.dart';
import 'package:loyalty_app/view/maintenance_booking_management/MaintenanceBookingManagement.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  DateTime _currentDate;
  String _warrantyCenter = 'KTX Khu B';
  String formattedDate;
  EventList<Event> _markedDateMap;
  int tag = 0;
  String _time = '8:00';
  TextEditingController _productSku = new TextEditingController();
  final MaintenanceBookingBloc maintenanceBookingBloc =
      new MaintenanceBookingBloc();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        child: Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            "Chọn thời gian bạn muốn bảo trì sản phẩm",
            style: TextStyle(color: Colors.grey, fontSize: mFontSize),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          child: CalendarCarousel<Event>(
            onDayPressed: (DateTime date, List<Event> events) {
              this.setState(() {
                _currentDate = date;
              });
            },
            weekendTextStyle: TextStyle(
              color: Colors.blue,
            ),
            thisMonthDayBorderColor: Colors.grey,
            weekFormat: false,
            markedDatesMap: _markedDateMap,
            height: 400.0,
            selectedDateTime: _currentDate,
            daysHaveCircularBorder: false,
            selectedDayBorderColor: mPrimaryColor,
            selectedDayButtonColor: mPrimaryColor,
            todayBorderColor: Colors.orangeAccent,
            todayButtonColor: Colors.orangeAccent,
            weekdayTextStyle: TextStyle(fontSize: 14.0, color: Colors.blue),
          ),
        ),
        setDate(),
        setTime(),
        setProduct(),
        setWarrantyCenter(),
        Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: SizedBox(
            width: size.width,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(color: mPrimaryColor)),
              color: mPrimaryColor,
              textColor: Colors.white,
              child: Text('Xác nhận', style: TextStyle(fontSize: 18)),
              onPressed: () {
                setState(() {
                  maintenanceBookingBloc
                      .booking(_productSku.text, _warrantyCenter, _currentDate,
                          _time, DateTime.now())
                      .then((value) => _showMaterialDialog());
                });
              },
            ),
          ),
        )
      ],
    ));
  }

  _showMaterialDialog() {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              title: new Image(
                width: 130,
                height: 130,
                image: AssetImage("assets/images/success.gif"),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    child: Text(
                      "Thông tin đăng kí của bạn đã được lưu lại!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        FlatButton(
                            child: Text('Quay lại',
                                style: TextStyle(
                                    color: mPrimaryColor, fontSize: 15)),
                            onPressed: () {
                              resetField();
                              Navigator.of(context, rootNavigator: true).pop();
                            }),
                        RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(color: mPrimaryColor)),
                            color: mPrimaryColor,
                            child: Text('Xem chi tiết',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15)),
                            onPressed: () {
                              resetField();
                              Navigator.of(context, rootNavigator: true).pop();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return MaintenanceBookingManagementScreen();
                                  },
                                ),
                              );
                            })
                      ])
                ],
              ),
            ));
  }

  Widget setDate() {
    if (_currentDate == null) {
      _currentDate = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day);
    } else {
      if (_currentDate.isBefore(DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day))) {
        return Container(
            child: AlertDialog(
          title: Text(
            'Ngày không hợp lệ!',
            style: TextStyle(
                color: Colors.red, fontWeight: FontWeight.w300, fontSize: 16),
          ),
        ));
      }
    }
    formattedDate = DateFormat('dd-MM-yyyy').format(_currentDate);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: [
                  Text(
                    "Ngày dự kiến: ",
                    style: TextStyle(fontSize: mFontSize, color: Colors.grey),
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                    formattedDate,
                    style: TextStyle(fontSize: 18.0),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget setTime() {
    List<String> options = [
      '8:00',
      '8:30',
      '9:00',
      '9:30',
      '10:00',
      '10:30',
      '11:00',
      '11:30',
      '13:00',
      '13:30',
      '14:00',
      '14:30',
      '15:00',
      '15:30',
      '16:00',
      '16:30',
    ];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      padding: EdgeInsets.fromLTRB(0, 8.0, 0, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: [
                  Text(
                    "Thời gian: ",
                    style: TextStyle(fontSize: mFontSize, color: Colors.grey),
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                    _time,
                    style: TextStyle(fontSize: 18.0),
                  )
                ],
              ),
            ],
          ),
          ChipsChoice<int>.single(
            value: tag,
            onChanged: (val) => setState(() {
              tag = val;
              _time = options[val];
            }),
            choiceItems: C2Choice.listFrom<int, String>(
              source: options,
              value: (i, v) => i,
              label: (i, v) => v,
            ),
          )
        ],
      ),
    );
  }

  Widget setProduct() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      padding: EdgeInsets.fromLTRB(0, 3.0, 0, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: [
                  Text(
                    "Mã sản phẩm: ",
                    style: TextStyle(fontSize: mFontSize, color: Colors.grey),
                  )
                ],
              ),
              Column(
                children: [
                  Container(
                    width: 150,
                    child: TextField(
                      controller: _productSku,
                      decoration: InputDecoration(hintText: 'SP1522219999'),
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget setWarrantyCenter() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      padding: EdgeInsets.fromLTRB(0, 3.0, 0, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: [
                  Text(
                    "Trung tâm bảo hành: ",
                    style: TextStyle(fontSize: mFontSize, color: Colors.grey),
                  )
                ],
              ),
              Column(
                children: [
                  DropdownButton<String>(
                    value: _warrantyCenter,
                    icon: FaIcon(FontAwesomeIcons.caretDown),
                    iconSize: 16,
                    elevation: 16,
                    style: TextStyle(color: Colors.black),
                    underline: Container(
                      height: 2,
                      color: mPrimaryColor,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        _warrantyCenter = newValue;
                      });
                    },
                    items: <String>[
                      'KTX Khu B',
                      'KTX Khu A',
                      'Trà Vinh',
                      'Vũng Tàu'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void resetField() {
    setState(() {
      _currentDate = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day);
      _warrantyCenter = 'KTX Khu B';
      formattedDate = DateFormat('dd-MM-yyyy').format(_currentDate);
      tag = 0;
      _time = '8:00';
      _productSku = new TextEditingController();
    });
  }
}
