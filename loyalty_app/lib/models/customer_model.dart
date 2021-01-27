class CustomerModel {
  final String customerId;
  final bool active;
  final String firstName;
  final String lastName;
  final String gender;
  final String email;
  final String phone;
  final String birthDate;
  final String levelId;
  final String loyaltyCardNumber;
  final bool agreement1;
  final bool agreement2;
  final bool agreement3;

  CustomerModel(
      {this.customerId,
      this.active,
      this.firstName,
      this.lastName,
      this.birthDate,
      this.email,
      this.gender,
      this.levelId,
      this.phone,
      this.loyaltyCardNumber,
      this.agreement1,
      this.agreement2,
      this.agreement3});

  factory CustomerModel.fromJson(Map<String, dynamic> parsedJson) {
    return CustomerModel(
      customerId: parsedJson["customerId"],
      active: parsedJson["active"],
      firstName: parsedJson["firstName"],
      lastName: parsedJson["lastName"],
      gender: parsedJson["gender"],
      email: parsedJson["email"],
      phone: parsedJson["phone"],
      birthDate: parsedJson["birthDate"],
      levelId: parsedJson["levelId"],
      loyaltyCardNumber: parsedJson["loyaltyCardNumber"],
      agreement1: parsedJson["agreement1"],
      agreement2: parsedJson["agreement2"],
      agreement3: parsedJson["agreement3"],
    );
  }
}

class CustomerStatusModel {
  double points;
  double p2pPoints;
  double totalEarnedPoints;
  double usedPoints;
  double expiredPoints;
  double lockedPoints;
  String level;
  String levelName;
  double levelConditionValue;
  String nextLevel;
  String nextLevelName;
  double nextLevelConditionValue;
  double transactionsAmountWithoutDeliveryCosts;
  double transactionsAmountToNextLevel;
  double averageTransactionsAmount;
  int transactionsCount;
  double transactionsAmount;
  String currency;
  double pointsExpiringNextMonth;

  CustomerStatusModel(
      {this.averageTransactionsAmount,
      this.currency,
      this.expiredPoints,
      this.level,
      this.levelConditionValue,
      this.levelName,
      this.lockedPoints,
      this.nextLevel,
      this.nextLevelConditionValue,
      this.nextLevelName,
      this.p2pPoints,
      this.points,
      this.pointsExpiringNextMonth,
      this.totalEarnedPoints,
      this.transactionsAmount,
      this.transactionsAmountToNextLevel,
      this.transactionsAmountWithoutDeliveryCosts,
      this.transactionsCount,
      this.usedPoints});

  factory CustomerStatusModel.fromJson(Map<String, dynamic> parsedJson) {
    return CustomerStatusModel(
      averageTransactionsAmount:
          double.parse(parsedJson["averageTransactionsAmount"]),
      currency: parsedJson["currency"],
      expiredPoints: double.parse(parsedJson["expiredPoints"].toString()),
      level: parsedJson["level"],
      levelConditionValue:
          double.parse(parsedJson["levelConditionValue"].toString()),
      levelName: parsedJson["levelName"],
      lockedPoints: double.parse(parsedJson["lockedPoints"].toString()),
      nextLevel: parsedJson["nextLevel"],
      nextLevelConditionValue:
          double.parse(parsedJson["nextLevelConditionValue"].toString()),
      nextLevelName: parsedJson["nextLevelName"],
      p2pPoints: double.parse(parsedJson["p2pPoints"].toString()),
      points: double.parse(parsedJson["points"].toString()),
      pointsExpiringNextMonth:
          double.parse(parsedJson["pointsExpiringNextMonth"].toString()),
      totalEarnedPoints:
          double.parse(parsedJson["totalEarnedPoints"].toString()),
      transactionsAmount:
          double.parse(parsedJson["transactionsAmount"].toString()),
      transactionsAmountToNextLevel:
          double.parse(parsedJson["transactionsAmountToNextLevel"].toString()),
      transactionsAmountWithoutDeliveryCosts: double.parse(
          parsedJson["transactionsAmountWithoutDeliveryCosts"].toString()),
      transactionsCount: parsedJson["transactionsCount"],
      usedPoints: double.parse(parsedJson["usedPoints"].toString()),
    );
  }
}
