class ListPointTransferModel {
  int total;
  List<PointTransferModel> pointTransferModels = [];

  ListPointTransferModel({this.pointTransferModels, this.total});

  ListPointTransferModel.fromJson(Map<String, dynamic> parsedJson) {
    total = parsedJson["total"];
    List<PointTransferModel> temp = [];
    for (int i = 0; i < total; i++) {
      PointTransferModel pointTransfer =
          PointTransferModel(parsedJson["transfers"][i]);
      temp.add(pointTransfer);
    }
    pointTransferModels = temp;
  }
}

class PointTransferModel {
  String pointsTransferId;
  String accountId;
  String customerId;
  DateTime createdAt;
  DateTime expiresAt;
  double value;
  String state;
  String type;
  //String transactionId;
  String comment;
  String issuer;

  PointTransferModel(item) {
    customerId = item["customerId"];
    pointsTransferId = item["pointsTransferId"];
    accountId = item["accountId"];
    createdAt = DateTime.parse(item["createdAt"]);
    expiresAt = DateTime.parse(item["expiresAt"]);
    value = item["value"].toDouble();
    state = item["state"];
    type = item["type"];
    //transactionId = item["transactionId"];
    comment = item["comment"];
    issuer = item["issuer"];
  }
}
