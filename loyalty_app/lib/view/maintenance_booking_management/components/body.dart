import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:loyalty_app/bloc/maintenance_booking_bloc.dart';
import 'package:loyalty_app/constant.dart';
import 'package:loyalty_app/models/maintenance_model.dart';
import 'package:loyalty_app/view/maintenance_booking_management/MaintenanceBookingManagement.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final MaintenanceBookingBloc maintenanceBookingBloc =
      MaintenanceBookingBloc();
  String _time = "8:00";
  String _warrantyCenter = "KTX Khu B";
  String _maintenanceId;
  DateTime _createAt;

  TextEditingController productSku = new TextEditingController();
  TextEditingController date = new TextEditingController();

  @override
  void initState() {
    super.initState();
    maintenanceBookingBloc.fetchListMaintenanceBook();
  }

  @override
  void dispose() {
    maintenanceBookingBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                "/home", (Route<dynamic> route) => false)),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Thông tin đăng kí bảo hành',
          style: TextStyle(
            fontSize: mFontSize,
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: maintenanceBookingBloc.maintenanceBook,
        builder: (context, AsyncSnapshot<ListMaintenanceModel> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.total == 0) {
              return Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.2,
                    ),
                    Text("Hiện tại bạn chưa có thông tin đăng kí nào!",
                        style:
                            TextStyle(color: Colors.grey, fontSize: mFontSize)),
                    SizedBox(
                      height: 20.0,
                    ),
                    SvgPicture.asset(
                      "assets/images/empty.svg",
                      height: size.height * 0.3,
                    ),
                  ],
                ),
              );
            }
            return buildList(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildList(AsyncSnapshot<ListMaintenanceModel> snapshot) {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(
        color: mDividerColor,
      ),
      itemCount: snapshot.data.total,
      itemBuilder: (context, index) {
        return bookingList(snapshot.data.maintenanceModels[index]);
      },
    );
  }

  Widget bookingList(MaintenanceModel maintenanceModel) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        child: Column(children: [
          Row(
            children: [
              Expanded(
                flex: 10,
                child: Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.clock,
                      color: Colors.grey,
                      size: 13,
                    ),
                    SizedBox(
                      width: 2.0,
                    ),
                    Text(
                        DateFormat("dd-MM-yyyy hh:mm a")
                            .format(maintenanceModel.createdAt),
                        style: TextStyle(fontSize: 12, color: Colors.grey))
                  ],
                ),
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Row(
            children: [
              Expanded(
                flex: 8,
                child: Text(
                  "Mã sản phẩm",
                  style: TextStyle(fontSize: mFontListTile),
                ),
              ),
              Expanded(
                flex: 16,
                child: Text(maintenanceModel.productSku,
                    style: TextStyle(
                        fontSize: mFontListTile, fontWeight: FontWeight.w700)),
              )
            ],
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Row(
            children: [
              Expanded(
                flex: 8,
                child: Text(
                  "Thời gian đến",
                  style: TextStyle(fontSize: mFontListTile),
                ),
              ),
              Expanded(
                flex: 16,
                child: Text(
                    DateFormat("dd-MM-yyyy")
                            .format(maintenanceModel.bookingDate) +
                        " " +
                        maintenanceModel.bookingTime,
                    style: TextStyle(
                        fontSize: mFontListTile, fontWeight: FontWeight.w700)),
              )
            ],
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Row(
            children: [
              Expanded(
                flex: 12,
                child: Text(
                  "Trung tâm bảo hành",
                  style: TextStyle(fontSize: mFontListTile),
                ),
              ),
              Expanded(
                flex: 16,
                child: Text(maintenanceModel.warrantyCenter,
                    style: TextStyle(
                        fontSize: mFontListTile, fontWeight: FontWeight.w700)),
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            children: [
              Expanded(
                flex: 6,
                child: Text(
                  "Tình trạng",
                  style: TextStyle(fontSize: mFontListTile),
                ),
              ),
              Expanded(
                flex: 15,
                child: Text(maintenanceModel.active ? "Chưa đến" : "Đã đến",
                    style: TextStyle(
                        fontSize: mFontListTile,
                        fontWeight: FontWeight.w700,
                        color: maintenanceModel.active
                            ? Colors.red
                            : Colors.grey)),
              ),
              Expanded(
                flex: 2,
                child: InkWell(
                  onTap: () => {
                    setState(() {
                      _createAt = maintenanceModel.createdAt;
                      _maintenanceId = maintenanceModel.maintenanceId;
                      _time = maintenanceModel.bookingTime;
                      _warrantyCenter = maintenanceModel.warrantyCenter;
                      date.text = DateFormat("yyyy-MM-dd")
                          .format(maintenanceModel.bookingDate);
                      productSku.text = maintenanceModel.productSku;
                    }),
                    if (maintenanceModel.active &&
                        (maintenanceModel.bookingDate
                                .compareTo(DateTime.now()) >
                            0))
                      {_editDialog()}
                  },
                  child: FaIcon(
                    maintenanceModel.active &&
                            (maintenanceModel.bookingDate
                                    .compareTo(DateTime.now()) >
                                0)
                        ? FontAwesomeIcons.penSquare
                        : FontAwesomeIcons.ban,
                    color: maintenanceModel.active &&
                            (maintenanceModel.bookingDate
                                    .compareTo(DateTime.now()) >
                                0)
                        ? Colors.green
                        : Colors.red,
                    size: 25,
                  ),
                ),
              )
            ],
          ),
        ]));
  }

  _editDialog() {
    var maskFormatter = new MaskTextInputFormatter(
        mask: '####-##-##', filter: {"#": RegExp(r'[0-9]')});
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

    List<String> centers = ['KTX Khu B', 'KTX Khu A', 'Trà Vinh', 'Vũng Tàu'];
    showDialog(
        context: context,
        builder: (_) => StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return new AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  title: new Text(
                    "Thay đổi thông tin đăng kí",
                    style: TextStyle(
                        color: mPrimaryColor, fontWeight: FontWeight.w400),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Mã sản phẩm:",
                        style: TextStyle(color: Colors.grey),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.0),
                      ),
                      TextFormField(
                        controller: productSku,
                        decoration: InputDecoration(
                            labelText: 'Nhập mã sản phẩm',
                            hintText: 'VD: SP1521999',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(width: 5.0),
                            )),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.0),
                      ),
                      Text("Ngày bảo hành:",
                          style: TextStyle(color: Colors.grey)),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.0),
                      ),
                      TextFormField(
                        controller: date,
                        inputFormatters: [maskFormatter],
                        decoration: InputDecoration(
                            labelText: 'Nhập ngày bạn đến (YYYYMMdd)',
                            hintText: 'VD: 20200215',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(width: 5.0),
                            )),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.0),
                      ),
                      Text("Trung tâm bảo bành:",
                          style: TextStyle(color: Colors.grey)),
                      DropdownButton<String>(
                        value: _warrantyCenter,
                        onChanged: (String value) {
                          setState(() {
                            _warrantyCenter = value;
                          });
                        },
                        items: centers.map((String item) {
                          return DropdownMenuItem<String>(
                              value: item, child: Text(item));
                        }).toList(),
                      ),
                      Row(
                        children: [
                          Text("Khung giờ:",
                              style: TextStyle(color: Colors.grey)),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                          ),
                          DropdownButton<String>(
                            hint: Text("Select item"),
                            value: _time,
                            onChanged: (String value) {
                              setState(() {
                                _time = value;
                              });
                            },
                            items: options.map((String item) {
                              return DropdownMenuItem<String>(
                                  value: item, child: Text(item));
                            }).toList(),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.0),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            FlatButton(
                                child: Text('Quay lại',
                                    style: TextStyle(
                                        color: mPrimaryColor, fontSize: 15)),
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                }),
                            RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide(color: mPrimaryColor)),
                                color: mPrimaryColor,
                                child: Text('Xác nhận',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15)),
                                onPressed: () {
                                  setState(() {
                                    print("date text:" + date.text);
                                    maintenanceBookingBloc
                                        .editBooking(
                                          _maintenanceId,
                                          productSku.text,
                                          _warrantyCenter,
                                          DateTime.parse(date.text),
                                          _time,
                                          DateTime.now(),
                                        )
                                        .then((value) => {
                                              if (value.isNotEmpty)
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) {
                                                        return MaintenanceBookingManagementScreen();
                                                      },
                                                    ),
                                                  )
                                                }
                                            });
                                  });
                                })
                          ])
                    ],
                  ));
            }));
  }
}
