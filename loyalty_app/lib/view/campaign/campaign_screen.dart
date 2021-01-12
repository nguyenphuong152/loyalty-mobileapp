import 'package:flutter/material.dart';
import 'package:loyalty_app/view/campaign/components/body.dart';

class CampaignScreen extends StatefulWidget {
  @override
  _CampaignScreenState createState() => _CampaignScreenState();
}

class _CampaignScreenState extends State<CampaignScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Body());
  }
}
