import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:loyalty_app/bloc/transaction_bloc.dart';
import 'package:loyalty_app/constant.dart';
import 'package:loyalty_app/models/transaction_model.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final TransactionBloc transactionBloc = TransactionBloc();
  @override
  void initState() {
    super.initState();
    transactionBloc.fetchTransactions();
  }

  @override
  void dispose() {
    transactionBloc.dispose();
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
          'Lịch sử giao dịch',
          style: TextStyle(
            fontSize: mFontSize,
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: transactionBloc.transactions,
        builder: (context, AsyncSnapshot<ListTransactionModel> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.total == 0) {
              return Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.2,
                    ),
                    Text("Hiện tại bạn chưa có giao dịch nào!",
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

  Widget buildList(AsyncSnapshot<ListTransactionModel> snapshot) {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(
        color: mDividerColor,
      ),
      itemCount: snapshot.data.total,
      itemBuilder: (context, index) {
        return transaction(snapshot.data.transactionModels[index]);
      },
    );
  }

  Widget transaction(TransactionModel transactionModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Icon(
              FontAwesomeIcons.shoppingCart,
              color: mPrimaryColor,
              size: 30.0,
            ),
          ),
          Expanded(flex: 4, child: detailInfo(transactionModel)),
        ],
      ),
    );
  }

  Widget detailInfo(TransactionModel transactionModel) {
    String amount = transactionModel.grossValue.toString() +
        " " +
        transactionModel.currency;
    String point = transactionModel.pointEarned.toString() + " pt";
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 30.0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "KTX Khu B - DHQG",
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  "Thời gian: ",
                  style: const TextStyle(fontSize: mFontListTile),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  DateFormat("dd-MM-yyyy hh:mm a")
                      .format(transactionModel.purchaseDate),
                  style: const TextStyle(fontSize: mFontListTile),
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  "Tổng tiền: ",
                  style: const TextStyle(fontSize: mFontListTile),
                ),
              ),
              Expanded(
                child: Text(
                  amount,
                  style: const TextStyle(fontSize: mFontListTile),
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  "Điểm nhận: ",
                  style: const TextStyle(fontSize: mFontListTile),
                ),
              ),
              Expanded(
                child: Text(
                  point,
                  style: const TextStyle(fontSize: mFontListTile),
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
