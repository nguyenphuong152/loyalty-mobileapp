import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter_svg/svg.dart';

class GradientCard extends StatelessWidget {
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
      this.startColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
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
                painter:
                    CustomCardShapePainter(_borderRadius, startColor, endColor),
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
                          name,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Avenir',
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          campaignActivity,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Avenir',
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.location_on,
                              color: Colors.white,
                              size: 16,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Flexible(
                              child: Text(
                                costInPoints,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Avenir',
                                ),
                              ),
                            ),
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
    );
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
