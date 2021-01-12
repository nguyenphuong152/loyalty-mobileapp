import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:loyalty_app/constant.dart';
import 'package:loyalty_app/models/customer_model.dart';
import 'package:http/http.dart' as http;
import 'package:loyalty_app/models/transaction_model.dart';
import 'package:loyalty_app/models/point_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerApiProvider {
  CustomerModel customer = CustomerModel();

  //fetch customer data
  Future<CustomerModel> fetchCustomerData() async {
    print("entered");
    //get value store in SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    String customerId = prefs.getString('customerId');

    Response response = await http.get(
      '$baseUrl/customer/$customerId',
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

  //fetch customer transaction
  Future<ListTransactionModel> fetchTransactions() async {
    print("entered");
    //get value store in SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');

    Response response = await http.get(
      '$baseUrl/customer/transaction',
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token"
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      return ListTransactionModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load transactionn info');
    }
  }

  //fetch customer status
  Future<CustomerStatusModel> fetchCustomerStatus() async {
    print("entered");
    //get value store in SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    String customerId = prefs.getString('customerId');

    Response response = await http.get(
      '$baseUrl/customer/$customerId/status',
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token"
      },
    );

    if (response.statusCode == 200) {
      return CustomerStatusModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load user status');
    }
  }

  //fetch list point transfer
  Future<ListPointTransferModel> fetchCustomerPointTransfer() async {
    print("entered");
    //get value store in SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');

    Response response = await http.get(
      '$baseUrl/customer/points/transfer',
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token"
      },
    );

    if (response.statusCode == 200) {
      return ListPointTransferModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load point transfer');
    }
  }
}
