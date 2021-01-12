class ListCampaignModel {
  int total;
  List<CampaignModel> campaignModels = [];

  ListCampaignModel({this.campaignModels, this.total});

  ListCampaignModel.fromJson(Map<String, dynamic> parsedJson) {
    total = parsedJson["total"];
    List<CampaignModel> temp = [];
    for (int i = 0; i < total; i++) {
      CampaignModel campaign = CampaignModel(parsedJson["campaigns"][i]);
      temp.add(campaign);
    }
    campaignModels = temp;
  }
}

class CampaignModel {
  String name;
  String campaignId;
  String reward;
  bool active;
  int costInPoints;
  bool singleCoupon;
  bool unlimited;
  //String transactionId;
  int limit;
  int limitPerUser;
  // bool campaignActivity;
  // bool campaignVisibility;
  int daysInactive;
  int daysValid;
  bool featured;
  bool public;
  int usageLeft;
  int usageLeftForCustomer;
  bool canBeBoughtByCustomer;
  int visibleForCustomersCount;
  int usersWhoUsedThisCampaignCount;

  CampaignModel(item) {
    name = item["name"];
    campaignId = item["campaignId"];
    reward = item["reward"];
    active = item["active"];
    costInPoints = item["costInPoints"];
    singleCoupon = item["singleCoupon"];
    unlimited = item["unlimited"];
    limit = item["limit"];
    limitPerUser = item["limitPerUser"];
    // campaignActivity = item["campaignActivity"];
    // campaignVisibility = item["campaignVisibility"];
    daysInactive = item["daysInactive"];
    daysValid = item["daysValid"];
    featured = item["featured"];
    public = item["public"];
    usageLeft = item["usageLeft"];
    usageLeftForCustomer = item["usageLeftForCustomer"];
    canBeBoughtByCustomer = item["canBeBoughtByCustomer"];
    visibleForCustomersCount = item["visibleForCustomersCount"];
    usersWhoUsedThisCampaignCount = item["usersWhoUsedThisCampaignCount"];
  }
}
