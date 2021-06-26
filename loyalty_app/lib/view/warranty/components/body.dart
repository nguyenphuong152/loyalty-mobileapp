import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loyalty_app/constant.dart';
import 'package:loyalty_app/models/product_model.dart';
import 'package:loyalty_app/view/warranty/components/booking_confirm.dart';
import 'package:table_calendar/table_calendar.dart';

class Body extends StatefulWidget {
  final ProductModel product;

  Body(this.product);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  DateTime _currentDate;
  String formattedDate;
  int tag = 0;
  int tag1 = -1;
  int tag2 = -1;
  int tag3 = -1;
  String _time = '9:00';

  CalendarController _calendarController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setDate();
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _calendarController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            TableCalendar(
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  //setDate();
                  _currentDate = selectedDay;
                });
              },
              startDay: DateTime.now(),
              calendarController: _calendarController,
              startingDayOfWeek: StartingDayOfWeek.monday,
              calendarStyle: CalendarStyle(
                  weekdayStyle: dayStyle(FontWeight.normal),
                  weekendStyle: dayStyle(FontWeight.normal),
                  selectedColor: mSecondPrimaryColor,
                  todayColor: mPrimaryColor),
              daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                  weekendStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
              headerStyle: HeaderStyle(
                  formatButtonVisible: false, centerHeaderTitle: true),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                  color: mPrimaryColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(56),
                      topRight: Radius.circular(56))),
              child: Column(
                children: [
                  setTime(),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                            side: BorderSide(color: mPrimaryColor)),
                        color: Colors.white,
                        textColor: mPrimaryColor,
                        child:
                            Text("Tiếp Theo", style: TextStyle(fontSize: 18)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return BookingConfirmed(
                                  _currentDate,
                                  _time,
                                  '',
                                  widget.product,
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void setDate() {
    if (_currentDate == null) {
      _currentDate = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day);
    }
    formattedDate = DateFormat('dd-MM-yyyy').format(_currentDate);
  }

  Widget setTime() {
    List<String> options1 = [
      '9:00',
      '9:30',
      '10:00',
      '10:30',
    ];

    List<String> options2 = [
      '13:00',
      '13:30',
      '14:00',
      '14:30',
    ];
    List<String> options3 = [
      '15:00',
      '15:30',
      '16:00',
      '16:30',
    ];

    return Container(
      padding: EdgeInsets.only(top: 15),
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              "Sáng ",
              style: TextStyle(fontSize: mFontSize, color: Colors.white),
            ),
          ),
          ChipsChoice<int>.single(
            crossAxisAlignment: CrossAxisAlignment.start,
            value: tag,
            onChanged: (val) => setState(() {
              tag = val;
              tag2 = -1;
              tag1 = -1;
              _time = options1[val];
            }),
            choiceItems: C2Choice.listFrom<int, String>(
              source: options1,
              value: (i, v) => i,
              label: (i, v) => v,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              "Trưa ",
              style: TextStyle(fontSize: mFontSize, color: Colors.white),
            ),
          ),
          ChipsChoice<int>.single(
            crossAxisAlignment: CrossAxisAlignment.start,
            value: tag1,
            onChanged: (val) => setState(() {
              tag1 = val;
              tag = -1;
              tag2 = -1;
              _time = options2[val];
            }),
            choiceItems: C2Choice.listFrom<int, String>(
              source: options2,
              value: (i, v) => i,
              label: (i, v) => v,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              "Chiều ",
              style: TextStyle(fontSize: mFontSize, color: Colors.white),
            ),
          ),
          ChipsChoice<int>.single(
            crossAxisAlignment: CrossAxisAlignment.start,
            value: tag2,
            onChanged: (val) => setState(() {
              tag2 = val;
              tag = -1;
              tag1 = -1;
              _time = options3[val];
            }),
            choiceItems: C2Choice.listFrom<int, String>(
              source: options3,
              value: (i, v) => i,
              label: (i, v) => v,
            ),
          )
        ],
      ),
    );
  }
}
