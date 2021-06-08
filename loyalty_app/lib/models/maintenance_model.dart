class ListMaintenanceModel {
  int total;
  List<MaintenanceModel> maintenanceModels = [];

  ListMaintenanceModel({this.maintenanceModels, this.total});

  ListMaintenanceModel.fromJson(Map<String, dynamic> parsedJson) {
    total = parsedJson["total"];
    List<MaintenanceModel> temp = [];
    for (int i = 0; i < total; i++) {
      MaintenanceModel trans = MaintenanceModel(parsedJson["maintenances"][i]);
      print(trans.bookingDate);
      temp.add(trans);
    }
    maintenanceModels = temp;
  }
}

class MaintenanceModel {
  String maintenanceId;
  String productSku;
  DateTime bookingDate;
  String bookingTime;
  String warrantyCenter;
  DateTime createdAt;
  bool active;

  MaintenanceModel(item) {
    maintenanceId = item["maintenanceId"];
    productSku = item["productSku"];
    bookingDate = DateTime.parse(item["bookingDate"]).toLocal();
    bookingTime = item["bookingTime"];
    warrantyCenter = item["warrantyCenter"];
    createdAt = DateTime.parse(item["createdAt"]);
    active = item["active"];
  }
}
