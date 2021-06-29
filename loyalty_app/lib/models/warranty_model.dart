class ListWarrantyModel {
  int total;
  List<WarrantyModel> warrantyModels = [];

  ListWarrantyModel({this.warrantyModels, this.total});

  ListWarrantyModel.fromJson(Map<String, dynamic> parsedJson) {
    total = parsedJson["total"];
    List<WarrantyModel> temp = [];
    for (int i = 0; i < total; i++) {
      WarrantyModel trans = WarrantyModel(parsedJson["warrantys"][i]);
      print(trans.maintenanceId);
      temp.add(trans);
    }
    warrantyModels = temp;
  }
}

class WarrantyModel {
  String maintenanceId;
  String productSku;
  DateTime bookingDate;
  String bookingTime;
  String warrantyCenter;
  DateTime createdAt;
  bool active;
  String discription;
  String cost;
  String paymentStatus;

  WarrantyModel(item) {
    maintenanceId = item["warrantyId"];
    productSku = item["productSku"];
    bookingDate = DateTime.parse(item["bookingDate"]).toLocal();
    bookingTime = item["bookingTime"];
    warrantyCenter = item["warrantyCenter"];
    createdAt = DateTime.parse(item["createdAt"]);
    active = item["active"];
    discription = item["discription"];
    cost = item["cost"];
    paymentStatus = item["paymentStatus"];
  }
}
