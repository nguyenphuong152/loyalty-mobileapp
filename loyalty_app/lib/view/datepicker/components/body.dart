import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:intl/intl.dart';
import 'package:loyalty_app/constant.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  DateTime _currentDate;
  String formattedDate;
  EventList<Event> _markedDateMap;
  int tag = 1;
  String _time = '8:00';
  // bool isDateValid = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        // margin: EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0),
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
        Container(
          padding: EdgeInsets.fromLTRB(0, 50.0, 0, 15.0),
          child: SizedBox(
            width: 200,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  side: BorderSide(color: mPrimaryColor)),
              color: mPrimaryColor,
              textColor: Colors.white,
              child: Text('Xác nhận', style: TextStyle(fontSize: 18)),
              onPressed: _showMaterialDialog,
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
              title: new Text("Xác nhận đăng kí"),
              content: new Text(
                  "Hệ thống đã lưu lại thông tin đăng kí của bạn. Hãy mang sản phẩm đến bảo trì đúng thời gian nhé!"),
              actions: <Widget>[
                FlatButton(
                  child: Text('Đóng'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
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
}
