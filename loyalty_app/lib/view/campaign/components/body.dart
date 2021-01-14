import 'package:flutter/material.dart';
import 'package:loyalty_app/bloc/coupon_bloc.dart';
import 'package:loyalty_app/component/coupon_card.dart';
import 'package:loyalty_app/constant.dart';
import 'package:loyalty_app/models/campaign_model.dart';
import 'package:loyalty_app/models/coupons_model.dart';
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
        style: TextStyle(color: Colors.black, fontSize: 16),
      ),
    ),
    Tab(
      child: Text(
        "Đã đổi",
        style: TextStyle(color: Colors.black, fontSize: 16),
      ),
    ),
  ];
  CampaignBloc campaignBloc = CampaignBloc();
  CouponBloc couponBloc = CouponBloc();
  @override
  void initState() {
    super.initState();
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
    // campaignBloc.dispose();
    // couponBloc.dispose();
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
            labelColor: mPrimaryColor,
            unselectedLabelColor: Colors.black,
            labelStyle: TextStyle(
                fontSize: 16, color: mPrimaryColor), //For Selected tab
            unselectedLabelStyle: TextStyle(fontSize: 16, color: Colors.black),
            indicatorColor: mPrimaryColor,
            onTap: (index) {
              if (index == 0) {
                campaignBloc.fetchCustomerCampaign();
              }
              couponBloc
                  .fetchCustomerCoupon(); // Tab index when user select it, it start from zero
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
              stream: couponBloc.customerCoupon,
              builder: (context, AsyncSnapshot<ListCouponModel> snapshot) {
                print(
                    "connection state: " + snapshot.connectionState.toString());
                if (snapshot.hasData) {
                  return buildListCoupon(snapshot);
                } else if (snapshot.hasError) {
                  return Text("LOi" + snapshot.error.toString());
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
          couponId: campaignModel.campaignId,
          name: campaignModel.name,
          campaignActivity: "All time active",
          costInPoints: campaignModel.costInPoints.toString(),
          startColor: Color(0xfffdfcfb),
          endColor: Color(0xffe2d1c3),
        ));
  }

  Widget buildListCoupon(AsyncSnapshot<ListCouponModel> snapshot) {
    return ListView.builder(
        itemCount: snapshot.data.total,
        itemBuilder: (context, index) {
          return buildDataCoupon(snapshot.data.couponModel[index]);
        });
  }

  Widget buildDataCoupon(CouponModel couponModel) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: CouponCard(
          activeSince: couponModel.activeSince.toString(),
          activeTo: couponModel.activeTo.toString(),
          couponCode: couponModel.couponCode,
          status: couponModel.status,
          startColor: Color(0xfffdfcfb),
          endColor: Color(0xffe2d1c3),
        ));
  }
}
