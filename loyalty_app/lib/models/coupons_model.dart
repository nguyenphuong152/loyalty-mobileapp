class ListCouponModel {
  int total;
  List<CouponModel> couponModel = [];

  ListCouponModel({this.couponModel, this.total});

  ListCouponModel.fromJson(Map<String, dynamic> parsedJson) {
    total = parsedJson["total"];
    List<CouponModel> temp = [];
    for (int i = 0; i < total; i++) {
      CouponModel coupon = CouponModel(parsedJson["CouponModel"][i]);
      temp.add(coupon);
    }
    couponModel = temp;
  }
}

class CouponModel {
  String canBeUsed;
  String campaignId;
  DateTime purchaseAt;
  double costInPoints;
  String used;
  String couponId;
  String couponCode;
  String status;
  DateTime activeSince;
  DateTime activeTo;
  String deliveryStatus;

  CouponModel(item) {
    canBeUsed = item["canBeUsed"];
    campaignId = item["campaignId"];
    purchaseAt = DateTime.parse(item["purchaseAt"]);
    costInPoints = item["costInPoints"].toDouble();
    used = item["used"];
    couponId = item["coupon"]["id"];
    couponCode = item["coupon"]["code"];
    status = item["status"];
    activeSince = DateTime.parse(item["activeSince"]);
    activeTo = DateTime.parse(item["activeTo"]);
    deliveryStatus = item["deliveryStatus"];
  }
}
