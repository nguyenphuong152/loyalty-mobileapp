import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loyalty_app/constant.dart';
import 'package:loyalty_app/models/customer_model.dart';
import 'package:loyalty_app/view/account_info/account_info_screen.dart';
import 'package:loyalty_app/bloc/point_bloc.dart';
import 'package:loyalty_app/view/point_transfer/point_transfer_screen.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final PointBloc pointBloc = PointBloc();
  @override
  void initState() {
    super.initState();
    pointBloc.fetchCustomerStatus();
  }

  @override
  void dispose() {
    pointBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          'Điểm của tôi',
          style: TextStyle(
            fontSize: mFontSize,
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      backgroundColor: mSecondaryColor,
      body: StreamBuilder(
        stream: pointBloc.customerStatus,
        builder: (context, AsyncSnapshot<CustomerStatusModel> snapshot) {
          if (snapshot.hasData) {
            return buildData(snapshot.data);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildData(CustomerStatusModel customerStatus) {
    return Column(
      children: [
        transactionAmount(customerStatus),
        SizedBox(
          height: 10,
        ),
        accumulated(customerStatus),
        SizedBox(
          height: 10,
        ),
        pointAmount(customerStatus),
      ],
    );
  }

  Widget pointAmount(CustomerStatusModel customerStatus) {
    Size size = MediaQuery.of(context).size;
    return Container(
        //margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        width: size.width,
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Điểm",
              textAlign: TextAlign.left,
              style:
                  TextStyle(fontSize: mFontTitle, fontWeight: FontWeight.w600),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
            Row(
              children: [
                Expanded(
                    flex: 4,
                    child: Text(
                      "Tổng điểm",
                      style: TextStyle(
                          fontSize: mFontSize, color: Colors.grey[600]),
                    )),
                Expanded(
                    flex: 2,
                    child: Text(
                      customerStatus.totalEarnedPoints.toString(),
                      style: TextStyle(fontSize: mFontSize),
                      textAlign: TextAlign.end,
                    ))
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Text("Điểm khả dụng",
                      style: TextStyle(
                          fontSize: mFontSize, color: Colors.grey[600])),
                ),
                Expanded(
                    flex: 2,
                    child: Text(customerStatus.points.toString(),
                        style: TextStyle(fontSize: mFontSize),
                        textAlign: TextAlign.end))
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Text("Điểm đã sử dụng",
                      style: TextStyle(
                          fontSize: mFontSize, color: Colors.grey[600])),
                ),
                Expanded(
                    flex: 2,
                    child: Text(customerStatus.usedPoints.toString(),
                        style: TextStyle(fontSize: mFontSize),
                        textAlign: TextAlign.end))
              ],
            ),
            Row(
              children: [
                Expanded(
                    flex: 4,
                    child: Text("Điểm bị khoá",
                        style: TextStyle(
                            fontSize: mFontSize, color: Colors.grey[600]))),
                Expanded(
                    flex: 2,
                    child: Text(customerStatus.lockedPoints.toString(),
                        style: TextStyle(fontSize: mFontSize),
                        textAlign: TextAlign.end))
              ],
            ),
            Row(
              children: [
                Expanded(
                    flex: 4,
                    child: Text("Điểm hết hạn",
                        style: TextStyle(
                            fontSize: mFontSize, color: Colors.grey[600]))),
                Expanded(
                    flex: 2,
                    child: Text(customerStatus.expiredPoints.toString(),
                        style: TextStyle(fontSize: mFontSize),
                        textAlign: TextAlign.end))
              ],
            ),
            InkWell(
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return AccountInfoScreen();
                    },
                  ),
                )
              },
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return PointTransfer();
                      },
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                  child: Row(
                    children: [
                      Text(
                        "Lịch sử điểm ",
                        style: TextStyle(fontSize: 15, color: mPrimaryColor),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      FaIcon(
                        FontAwesomeIcons.angleRight,
                        size: 18,
                        color: mPrimaryColor,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }

  Widget accumulated(CustomerStatusModel customerStatus) {
    Size size = MediaQuery.of(context).size;
    String amount = customerStatus.transactionsAmountToNextLevel.toString() +
        " " +
        customerStatus.currency;
    return Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        width: size.width,
        color: Colors.white,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Quá trình tích luỹ",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: mFontTitle, fontWeight: FontWeight.w600),
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
              Text(
                "Giá trị giao dịch cần đạt để thăng hạng là " + amount,
                style: TextStyle(fontSize: mFontSize),
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
              Text(
                "Chiết khấu cấp tiếp theo " + customerStatus.nextLevel,
                style: TextStyle(fontSize: mFontSize),
              )
            ]));
  }

  Widget transactionAmount(CustomerStatusModel customerStatus) {
    String totalTransaction = customerStatus.transactionsAmount.toString() +
        " " +
        customerStatus.currency;
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
      width: size.width,
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: SvgPicture.asset(
              "assets/images/crown.svg",
              height: size.height * 0.15,
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(50, 0, 0, 15),
            alignment: Alignment.center,
            child: LinearPercentIndicator(
              width: 250,
              lineHeight: 24.0,
              percent: customerStatus.transactionsAmount /
                  customerStatus.transactionsAmountToNextLevel,
              center: Text(
                totalTransaction,
                style: new TextStyle(fontSize: mFontSize),
              ),
              trailing: Icon(Icons.mood),
              linearStrokeCap: LinearStrokeCap.roundAll,
              backgroundColor: Colors.grey[300],
              progressColor: mLinear,
            ),
          ),
          Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
              alignment: Alignment.center,
              child: Text(
                  "Chiết khấu hiện tại" + " " + customerStatus.level.toString(),
                  style: TextStyle(fontSize: mFontSize)))
        ],
      ),
    );
  }
}
