import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loyalty_app/bloc/card_bloc.dart';
import 'package:loyalty_app/constant.dart';
import 'package:loyalty_app/models/carousel_model.dart';
import 'package:loyalty_app/models/customer_model.dart';
import 'package:loyalty_app/view/campaign/campaign_screen.dart';
import 'package:loyalty_app/view/datepicker/datepicker_screen.dart';
import 'package:loyalty_app/view/product/product_screen.dart';
import 'package:loyalty_app/view/stores/stores_screen.dart';
import 'package:loyalty_app/view/support/start_conversation_screen.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final CardBloc cardBloc = CardBloc();

  @override
  void initState() {
    super.initState();
    cardBloc.fetchCustomer();
  }

  @override
  void dispose() {
    cardBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int _current = 0;

    List<T> map<T>(List list, Function handler) {
      List<T> result = [];
      for (var i = 0; i < list.length; i++) {
        result.add(handler(i, list[i]));
      }
      return result;
    }

    return SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: mPrimaryColor,
                borderRadius: BorderRadius.all(Radius.circular(28) //
                    ),
              ),
              width: 344,
              height: 199,
              margin: EdgeInsets.all(10.0),
              child: StreamBuilder<CustomerModel>(
                  stream: cardBloc.customer,
                  builder: (context, AsyncSnapshot<CustomerModel> snapshot) {
                    print(snapshot.connectionState);
                    if (snapshot.hasData) {
                      return cardInfo(snapshot.data);
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }
                    return Center(child: CircularProgressIndicator());
                  }),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, top: 14),
              child: Text(
                "Danh mục dịch vụ",
                style: TextStyle(
                    fontSize: mFontSize,
                    color: Colors.black,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Container(
              height: 144,
              margin: EdgeInsets.only(left: 16, right: 16, top: 10),
              child: Column(
                children: <Widget>[
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return ProductScreen();
                                },
                              ),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 8),
                            padding: EdgeInsets.only(left: 16),
                            height: 64,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border:
                                    Border.all(color: mPrimaryColor, width: 1)),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.calendar_view_day_outlined),
                                Padding(
                                    padding: EdgeInsets.only(left: 16),
                                    child: Text(
                                      "Đặt lịch",
                                      style: Constants.titleService,
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return StartConverstionScreen();
                                },
                              ),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 8),
                            padding: EdgeInsets.only(left: 16),
                            height: 64,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border:
                                    Border.all(color: mPrimaryColor, width: 1)),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.support_agent_outlined),
                                Padding(
                                    padding: EdgeInsets.only(left: 16),
                                    child: Text(
                                      "Hỗ trợ",
                                      style: Constants.titleService,
                                    ))
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return CampaignScreen();
                                },
                              ),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 8),
                            padding: EdgeInsets.only(left: 16),
                            height: 64,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border:
                                    Border.all(color: mPrimaryColor, width: 1)),
                            child: Row(
                              children: <Widget>[
                                FaIcon(
                                  FontAwesomeIcons.gift,
                                  size: 18,
                                ),
                                Padding(
                                    padding: EdgeInsets.only(left: 16),
                                    child: Text(
                                      "Đổi điểm",
                                      style: Constants.titleService,
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return GetMyStores();
                                },
                              ),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 8),
                            padding: EdgeInsets.only(left: 18),
                            height: 64,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border:
                                    Border.all(color: mPrimaryColor, width: 1)),
                            child: Row(
                              children: <Widget>[
                                FaIcon(
                                  FontAwesomeIcons.store,
                                  size: 18,
                                ),
                                Padding(
                                    padding: EdgeInsets.only(left: 16),
                                    child: Text(
                                      "Cửa hàng",
                                      style: Constants.titleService,
                                    ))
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, top: 18),
              child: Text(
                "Khuyến mãi hấp dẫn 🎉",
                style: TextStyle(
                    fontSize: mFontSize,
                    color: Colors.black,
                    fontWeight: FontWeight.w700),
              ),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Row(
            //       children: map<Widget>(carousels, (index, image) {
            //         return Container(
            //           alignment: Alignment.centerLeft,
            //           height: 6,
            //           width: 6,
            //           margin: EdgeInsets.only(right: 8),
            //           decoration: BoxDecoration(
            //               shape: BoxShape.circle,
            //               color:
            //                   _current == index ? mPrimaryColor : Colors.grey),
            //         );
            //       }),
            //     )
            //   ],
            // ),
            Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 16, right: 16, top: 14),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 190,
                      // ignore: missing_required_param
                      child: Swiper(
                        onIndexChanged: (index) {
                          setState(() {
                            _current = index;
                          });
                        },
                        autoplay: true,
                        layout: SwiperLayout.DEFAULT,
                        itemCount: carousels.length,
                        itemBuilder: (BuildContext context, index) {
                          return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                    image: AssetImage(carousels[index].image),
                                    fit: BoxFit.cover)),
                          );
                        },
                      ),
                    )
                  ],
                )),
            SizedBox(
              height: 18,
            ),
          ]),
    );
  }

  Widget cardInfo(CustomerModel customer) {
    var _fullName = customer.lastName + " " + customer.firstName;
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Tên khách hàng",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    _fullName,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "ID",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    customer.loyaltyCardNumber,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              )
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Image.asset(
            "assets/images/login_bottom.png",
            width: size.width * 0.4,
          ),
        ),
        Positioned(
          top: 90,
          child: Container(
            padding: EdgeInsets.only(left: 25),
            child: BarcodeWidget(
              barcode: Barcode.code128(), // Barcode type and settings
              data: customer.loyaltyCardNumber, // Content
              width: 200,
              height: 60,
              color: Colors.white,
              drawText: false,
            ),
          ),
        ),
      ],
    );
  }
}
