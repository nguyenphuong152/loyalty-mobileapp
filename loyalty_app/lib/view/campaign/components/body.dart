import 'package:flutter/material.dart';
import 'package:loyalty_app/models/campaign_model.dart';
import 'package:loyalty_app/view/home/components/app_bar.dart';
import 'package:loyalty_app/component/gradient_card.dart';
import 'package:loyalty_app/bloc/campaign_bloc.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final CampaignBloc campaignBloc = CampaignBloc();
  @override
  void initState() {
    super.initState();
    campaignBloc.fetchCustomerCampaign();
  }

  @override
  void dispose() {
    campaignBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(context),
      body: StreamBuilder(
        stream: campaignBloc.campaign,
        builder: (context, AsyncSnapshot<ListCampaignModel> snapshot) {
          if (snapshot.hasData) {
            return buildList(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildList(AsyncSnapshot<ListCampaignModel> snapshot) {
    return ListView.builder(
      itemCount: snapshot.data.total,
      itemBuilder: (context, index) {
        return buildData(snapshot.data.campaignModels[index]);
      },
    );
  }

  Widget buildData(CampaignModel campaignModel) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: GradientCard(
          name: campaignModel.name,
          campaignActivity: "All time active",
          costInPoints: campaignModel.costInPoints.toString(),
          startColor: Color(0xffa1c4fd),
          endColor: Color(0xffc2e9fb),
        ));
  }
}
