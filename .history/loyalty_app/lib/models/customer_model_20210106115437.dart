class CustomerModel {
  String _customerId;
  bool _active;
  String _firstName;
  String _lastName;
  String _gender;
  String _email;
  String _phone;
  DateTime _birthDate;
  String _levelId;
  bool _agreement1;
  bool _agreement2;
  bool _agreement3;

  String get customerId => _customerId;
  bool get active => _active;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get gender => _gender;
  String get email => _email;
  String get phone => _phone;
  DateTime get birthDate => _birthDate;
  String get levelId => _levelId;
  bool get agreement2 => _agreement2;
  bool get agreement1 => _agreement1;
  bool get agreement3 => _agreement3;

  CustomerModel.fromJson(Map<String, dynamic> parsedJson) {
    _customerId = parsedJson["customerId"];
    _active = parsedJson["active"];
    _firstName = parsedJson["firstName"];
    _lastName = parsedJson["lastName"];
    _gender = parsedJson["gender"];
    _email = parsedJson["email"];
    _phone = parsedJson["phone"];
    _birthDate = parsedJson["birthDate"];
    _levelId = parsedJson["levelId"];
    _agreement1 = parsedJson["agreement1"];
    _agreement2 = parsedJson["agreement2"];
    _agreement3 = parsedJson["agreement3"];
  }
}
