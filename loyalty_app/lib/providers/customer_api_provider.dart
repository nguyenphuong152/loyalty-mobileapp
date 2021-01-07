import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:loyalty_app/constant.dart';
import 'package:loyalty_app/models/customer_model.dart';
import 'package:http/http.dart' as http;
import 'package:loyalty_app/src/services/auth_service.dart';

class CustomerApiProvider {
  CustomerModel customer = CustomerModel();

  Future<CustomerModel> fetchCustomerData() async {
    print("entered");
    var tokens = await AuthService.getToken();
    var token = tokens["token"];

    Response response = await http.get(
      '$baseUrl/customer/11111111-0000-474c-b092-b0dd880c07e1',
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token"
      },
    );

    if (response.statusCode == 200) {
      return CustomerModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load user info');
    }
  }
}
