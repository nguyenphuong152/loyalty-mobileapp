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
      agreement1: parsedJson["agreement1"],
      agreement2: parsedJson["agreement2"],
      agreement3: parsedJson["agreement3"],
    );
  }
}
