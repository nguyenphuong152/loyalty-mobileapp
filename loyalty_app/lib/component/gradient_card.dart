import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter_svg/svg.dart';
import 'package:loyalty_app/bloc/coupon_bloc.dart';
import 'package:loyalty_app/constant.dart';
import 'package:loyalty_app/view/campaign/campaign_screen.dart';

class GradientCard extends StatelessWidget {
  final String couponId;
  final String name;
  final String campaignActivity;
  final String costInPoints;
  final Color startColor;
  final Color endColor;
  final double _borderRadius = 24;

  const GradientCard(
      {Key key,
      this.name,
      this.campaignActivity,
      this.costInPoints,
      this.endColor,
      this.couponId,
      this.startColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    CouponBloc couponBloc = CouponBloc();

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
        child: GestureDetector(
          onTap: () {
            _showWaitingDialog(context);
            couponBloc
                .buyCoupon(couponId)
                .then((value) => {_showDialog(context)});
          },
          child: Stack(
            children: <Widget>[
              Container(
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(_borderRadius),
                  gradient: LinearGradient(
                      colors: [startColor, endColor],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                  boxShadow: [
                    BoxShadow(
                      color: endColor,
                      blurRadius: 12,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                top: 0,
                child: CustomPaint(
                  size: Size(100, 150),
                  painter: CustomCardShapePainter(
                      _borderRadius, startColor, endColor),
                ),
              ),
              Positioned.fill(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: SvgPicture.asset(
                        "assets/images/present.svg",
                        height: 70,
                      ),
                      flex: 2,
                    ),
                    Expanded(
                      flex: 4,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            name == "Inactive"
                                ? "Khuyến mãi 20%"
                                : "Khuyễn mãi 5%",
                            style: TextStyle(
                                fontSize: footnote,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 10),
                          Text(
                            campaignActivity,
                            style: TextStyle(
                              fontSize: footnote,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Icon(
                                Icons.offline_bolt_outlined,
                                color: Colors.amber[900],
                                size: footnote,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Flexible(
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.baseline,
                                    children: [
                                      Text(
                                        costInPoints,
                                        style: TextStyle(
                                          fontSize: footnote,
                                        ),
                                      ),
                                      Text(
                                        " điểm",
                                        style: TextStyle(
                                          fontSize: footnote,
                                        ),
                                      ),
                                    ]),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  child: Text(
                                    "Đổi điểm",
                                    style: TextStyle(
                                        color: Colors.amber[900],
                                        fontSize: footnote,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showDialog(BuildContext context) {
    Navigator.pop(context);
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              title: Container(
                child: Column(
                  children: [
                    Image(
                      width: 250,
                      height: 250,
                      image: AssetImage("assets/images/success.gif"),
                    ),
                    Text(
                      "Chúc mừng bạn đã đổi điểm thành công!",
                      style: TextStyle(fontSize: 16, color: mPrimaryColor),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: mPrimaryColor)),
                        color: mPrimaryColor,
                        child: Text('Quay lại',
                            style:
                                TextStyle(color: Colors.white, fontSize: 15)),
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).pop();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return CampaignScreen();
                              },
                            ),
                          );
                        })
                  ],
                ),
              ),
            ));
  }

  _showWaitingDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              title: Center(child: CircularProgressIndicator()),
            ));
  }
}

class CustomCardShapePainter extends CustomPainter {
  final double radius;
  final Color startColor;
  final Color endColor;

  CustomCardShapePainter(this.radius, this.startColor, this.endColor);

  @override
  void paint(Canvas canvas, Size size) {
    var radius = 24.0;

    var paint = Paint();
    paint.shader = ui.Gradient.linear(
        Offset(0, 0), Offset(size.width, size.height), [
      HSLColor.fromColor(startColor).withLightness(0.8).toColor(),
      endColor
    ]);

    var path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width - radius, size.height)
      ..quadraticBezierTo(
          size.width, size.height, size.width, size.height - radius)
      ..lineTo(size.width, radius)
      ..quadraticBezierTo(size.width, 0, size.width - radius, 0)
      ..lineTo(size.width - 1.5 * radius, 0)
      ..quadraticBezierTo(-radius, 2 * radius, 0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
