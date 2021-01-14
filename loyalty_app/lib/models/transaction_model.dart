class ListTransactionModel {
  int total;
  List<TransactionModel> transactionModels = [];

  ListTransactionModel({this.transactionModels, this.total});

  ListTransactionModel.fromJson(Map<String, dynamic> parsedJson) {
    total = parsedJson["total"];
    List<TransactionModel> temp = [];
    for (int i = 0; i < total; i++) {
      TransactionModel trans = TransactionModel(parsedJson["transactions"][i]);
      temp.add(trans);
    }
    transactionModels = temp;
  }
}

class TransactionModel {
  String transactionId;
  String customerId;
  String documentType;
  DateTime purchaseDate;
  String purchasePlace;
  List<TransactionDetail> transactionDetails = [];
  double grossValue;
  String currency;
  double pointEarned;

  TransactionModel(item) {
    customerId = item["customerId"];
    documentType = item["documentType"];
    purchaseDate = DateTime.parse(item["purchaseDate"]);
    purchasePlace = item["purchasePlace"];
    transactionId = item["transactionId"];
    currency = item["currency"];
    grossValue = item["grossValue"].toDouble();
    pointEarned = item["pointsEarned"].toDouble();

    List<TransactionDetail> temp = [];
    for (int i = 0; i < item["items"].length; i++) {
      TransactionDetail trans = TransactionDetail(item["items"][i]);
      temp.add(trans);
    }
    transactionDetails = temp;
  }

  // TransactionModel.fromJson(Map<String, dynamic> parsedJson) {
  //   customerId = parsedJson["customerId"];
  //   documentType = parsedJson["documentType"];
  //   purchaseDate = parsedJson["purchaseDate"];
  //   purchasePlace = parsedJson["purchasePlace"];
  //   transactionId = parsedJson["transactionId"];
  //   currency = parsedJson["currency"];
  //   grossValue = parsedJson["grossValue"];
  //   pointEarned = parsedJson["pointEarned"];
  //   List<TransactionDetail> temp = [];
  //   for (int i = 0; i < parsedJson["items"].length; i++) {
  //     TransactionDetail trans = TransactionDetail(parsedJson["items"][i]);
  //     temp.add(trans);
  //   }
  //   transactionDetails = temp;
  // }
}

class TransactionDetail {
  String sku;
  String name;
  int quantity;
  double grossValue;
  String category;

  TransactionDetail(item) {
    sku = item['sku']['code'];
    name = item['name'];
    quantity = item['quantity'];
    grossValue = item['grossValue'].toDouble();
    category = item['category'];
  }
}
