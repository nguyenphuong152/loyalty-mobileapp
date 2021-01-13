import 'package:flutter/material.dart';
import 'package:loyalty_app/constant.dart';
import 'package:loyalty_app/models/campaign_model.dart';
import 'package:loyalty_app/view/home/components/app_bar.dart';
import 'package:loyalty_app/component/gradient_card.dart';
import 'package:loyalty_app/bloc/campaign_bloc.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  TabController _controller;
  int _selectedIndex = 0;

  List<Widget> list = [
    Tab(
      child: Text(
        "Mới nhất",
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.w400, fontSize: 16),
      ),
    ),
    Tab(
      child: Text(
        "Đã đổi",
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.w400, fontSize: 16),
      ),
    ),
  ];

  CampaignBloc campaignBloc = CampaignBloc();
  @override
  void initState() {
    super.initState();
    campaignBloc.fetchCustomerCampaign();
    _controller = TabController(length: list.length, vsync: this);
    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
      print("Selected Index: " + _controller.index.toString());
    });
  }

  // @override
  // void didChangeDependencies() {
  //   print("heleo");
  //   campaignBloc.fetchCustomerCampaign();
  //   super.didChangeDependencies();
  // }

  @override
  void dispose() {
    campaignBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          bottom: TabBar(
            onTap: (index) {
              // Tab index when user select it, it start from zero
            },
            controller: _controller,
            tabs: list,
          ),
          title: Text(
            'Điểm thưởng',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: mFontTitle),
          ),
        ),
        body: TabBarView(
          controller: _controller,
          children: [
            StreamBuilder(
              stream: campaignBloc.campaign,
              builder: (context, AsyncSnapshot<ListCampaignModel> snapshot) {
                print(
                    "connection state: " + snapshot.connectionState.toString());
                if (snapshot.hasData) {
                  return buildList(snapshot);
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
            StreamBuilder(
              stream: campaignBloc.campaign,
              builder: (context, AsyncSnapshot<ListCampaignModel> snapshot) {
                print(
                    "connection state: " + snapshot.connectionState.toString());
                if (snapshot.hasData) {
                  return buildList(snapshot);
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
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
          startColor: Color(0xfffdfcfb),
          endColor: Color(0xffe2d1c3),
        ));
  }
}
