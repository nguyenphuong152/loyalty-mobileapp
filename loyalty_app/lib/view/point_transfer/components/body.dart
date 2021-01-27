import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:loyalty_app/bloc/point_transfer_bloc.dart';
import 'package:loyalty_app/constant.dart';
import 'package:loyalty_app/view/home/components/app_bar.dart';
import 'package:loyalty_app/models/point_model.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final PointTransferBloc pointBloc = PointTransferBloc();
  @override
  void initState() {
    super.initState();
    pointBloc.fetchPointTransfer();
  }

  @override
  void dispose() {
    pointBloc.dispose();
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
            onPressed: () => Navigator.of(context).pop()),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Lịch sử sử dụng điểm',
          style: TextStyle(
            fontSize: mFontSize,
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: pointBloc.pointTransfer,
        builder: (context, AsyncSnapshot<ListPointTransferModel> snapshot) {
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

  Widget buildList(AsyncSnapshot<ListPointTransferModel> snapshot) {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(
        color: mDividerColor,
      ),
      itemCount: snapshot.data.total,
      itemBuilder: (context, index) {
        return pointTransfer(snapshot.data.pointTransferModels[index]);
      },
    );
  }

  Widget pointTransfer(PointTransferModel pointTransferModel) {
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
                            .format(pointTransferModel.createdAt),
                        style: TextStyle(fontSize: 12, color: Colors.grey))
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: FaIcon(
                  pointTransferModel.state == "active"
                      ? FontAwesomeIcons.solidCheckSquare
                      : FontAwesomeIcons.solidMinusSquare,
                  color: pointTransferModel.state == "active"
                      ? Colors.green
                      : Colors.red,
                  size: 16,
                ),
              )
            ],
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  "Điểm",
                  style: TextStyle(fontSize: mFontListTile),
                ),
              ),
              Expanded(
                flex: 15,
                child: Text(pointTransferModel.value.toString(),
                    style: TextStyle(
                        fontSize: mFontListTile, fontWeight: FontWeight.w700)),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  "Loại",
                  style: TextStyle(fontSize: mFontListTile),
                ),
              ),
              Expanded(
                flex: 15,
                child: Text(
                    pointTransferModel.type == "adding"
                        ? "Tích điểm"
                        : "Sử dụng điểm",
                    style: TextStyle(
                        fontSize: mFontListTile, fontWeight: FontWeight.w700)),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 4,
                child: Text(
                  "Nội dung",
                  style: TextStyle(fontSize: mFontListTile),
                ),
              ),
              Expanded(
                flex: 13,
                child: Text(
                    pointTransferModel.comment == null
                        ? ""
                        : pointTransferModel.comment,
                    style: TextStyle(
                        fontSize: mFontListTile, fontWeight: FontWeight.w700)),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 6,
                child: Text(
                  "Hạn sử dụng",
                  style: TextStyle(fontSize: mFontListTile),
                ),
              ),
              Expanded(
                flex: 12,
                child: Text(
                    DateFormat("dd-MM-yyyy hh:mm a")
                        .format(pointTransferModel.expiresAt),
                    style: TextStyle(
                        fontSize: mFontListTile, fontWeight: FontWeight.w700)),
              )
            ],
          ),
        ]));
  }
}
