import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:loyalty_app/constant.dart';
import 'package:loyalty_app/models/product_model.dart';
import 'package:loyalty_app/view/warranty/edit_booking/edit_booking_confirm.dart';
import 'package:table_calendar/table_calendar.dart';

class EditBookingScreen extends StatefulWidget {
  final ProductModel product;
  final DateTime bookingDate;
  final String bookingTime;
  final String center;
  final int typeBooking;
  final String bookingNumber;
  final String dis;
  final String cost;
  final String paymentStatus;

  //1-warranty , 2-maintance

  EditBookingScreen(
      this.product,
      this.bookingDate,
      this.bookingTime,
      this.center,
      this.bookingNumber,
      this.dis,
      this.cost,
      this.paymentStatus,
      this.typeBooking);

  @override
  _EditBookingScreenState createState() => _EditBookingScreenState();
}

class _EditBookingScreenState extends State<EditBookingScreen> {
  DateTime _currentDate;

  int tag = -1;
  int tag1 = -1;
  int tag2 = -1;

  String _time;

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

  CalendarController _calendarController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setData();

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
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                "Vui lòng chọn thời gian đến",
                style: TextStyle(fontSize: subhead, color: Colors.grey),
              ),
              TableCalendar(
                initialSelectedDay: widget.bookingDate,
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
                  selectedColor: mPrimaryColor,
                ),
                daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: TextStyle(
                        color: mPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: footnote),
                    weekendStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: footnote)),
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
                          child: Text("Tiếp Theo",
                              style: TextStyle(fontSize: body)),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return EditBookingConfirm(
                                      widget.product,
                                      _currentDate,
                                      _time,
                                      widget.center,
                                      widget.bookingNumber,
                                      widget.dis,
                                      widget.cost,
                                      widget.paymentStatus,
                                      widget.typeBooking);
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
      ),
    );
  }

  Widget setTime() {
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
              style: TextStyle(fontSize: subhead, color: Colors.white),
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
              style: TextStyle(fontSize: subhead, color: Colors.white),
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
              style: TextStyle(fontSize: subhead, color: Colors.white),
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

  void findSelectedTime() {
    for (int i = 0; i < options1.length; i++) {
      if (widget.bookingTime == options1[i]) {
        {
          tag = i;
          return;
        }
      }
    }

    for (int i = 0; i < options2.length; i++) {
      if (widget.bookingTime == options2[i]) {
        tag1 = i;
        return;
      }
    }

    for (int i = 0; i < options3.length; i++) {
      if (widget.bookingTime == options3[i]) {
        tag2 = i;
        return;
      }
    }
  }

  void setData() {
    _currentDate = widget.bookingDate;
    _time = widget.bookingTime;
    findSelectedTime();
  }
}
