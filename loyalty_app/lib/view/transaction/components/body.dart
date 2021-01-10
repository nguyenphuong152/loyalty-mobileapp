import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loyalty_app/bloc/transaction_bloc.dart';
import 'package:loyalty_app/constant.dart';
import 'package:loyalty_app/models/transaction_model.dart';
import 'package:loyalty_app/view/home/components/app_bar.dart';

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
    return Scaffold(
      appBar: homeAppBar(context),
      body: StreamBuilder(
        stream: transactionBloc.transactions,
        builder: (context, AsyncSnapshot<ListTransactionModel> snapshot) {
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

  Widget buildList(AsyncSnapshot<ListTransactionModel> snapshot) {
    return ListView.builder(
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
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 50.0, 0),
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
                child: Text(
                  transactionModel.purchaseDate,
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
                  transactionModel.grossValue.toString(),
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
                  transactionModel.pointEarned.toString(),
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
