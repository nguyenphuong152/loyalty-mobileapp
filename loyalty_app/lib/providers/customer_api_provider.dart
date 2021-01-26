import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:loyalty_app/constant.dart';
import 'package:loyalty_app/models/coupons_model.dart';
import 'package:loyalty_app/models/customer_model.dart';
import 'package:http/http.dart' as http;
import 'package:loyalty_app/models/maintenance_model.dart';
import 'package:loyalty_app/models/transaction_model.dart';
import 'package:loyalty_app/models/point_model.dart';
import 'package:loyalty_app/models/campaign_model.dart';
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

  //fetch customer campaign
  Future<ListCampaignModel> fetchCustomerCampaign() async {
    print("entered");
    //get value store in SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');

    Response response = await http.get(
      '$baseUrl/customer/campaign/available',
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token"
      },
    );

    if (response.statusCode == 200) {
      return ListCampaignModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load point transfer');
    }
  }

  //buy coupon(campaign)
  dynamic buyCoupon(String couponId) async {
    print("entered");
    //get value store in SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');

    Response response = await http.post(
      '$baseUrl/customer/campaign/$couponId/buy',
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token"
      },
    );

    if (response.statusCode == 200) {
      print("success");
      return response.body;
    } else {
      throw Exception('Failed to buy');
    }
  }

  Future<ListCouponModel> fetchCustomerCoupon() async {
    print("entered");
    //get value store in SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');

    Response response = await http.get(
      '$baseUrl/customer/campaign/bought',
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token"
      },
    );

    if (response.statusCode == 200) {
      return ListCouponModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load cus coupon');
    }
  }

  Future<ListMaintenanceModel> fetchCustomerMaintenanceBooking() async {
    print("entered");
    //get value store in SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');

    Response response = await http.get(
      '$baseUrl/customer/maintenance',
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token"
      },
    );

    if (response.statusCode == 200) {
      print(response.body);
      return ListMaintenanceModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load maintenance list');
    }
  }

  Future<String> booking(
    String productSku,
    String warrantyCenter,
    DateTime bookingDate,
    String bookingTime,
    DateTime createAt,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email');
    String name = prefs.getString('name');
    String phone = prefs.getString('phone');
    String loyaltyCardNumber = prefs.getString('loyaltyCardNumber');
    String token = prefs.getString('token');

    final data = jsonEncode({
      "maintenance": {
        "maintenanceData": {
          "productSku": productSku,
          "bookingDate": bookingDate.toIso8601String(),
          "bookingTime": bookingTime,
          "warrantyCenter": warrantyCenter,
          "createdAt": createAt.toIso8601String(),
          "active": true
        },
        "customerData": {
          "email": email,
          "name": name,
          "nip": "aaa",
          "phone": phone,
          "loyaltyCardNumber": loyaltyCardNumber,
        }
      }
    });

    try {
      var res = await http.post(
        '$baseUrl/maintenance',
        body: data,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token"
        },
      );
      print(res.statusCode);
      if (res.statusCode == 200) {
        print("success");
        return res.body;
      } else {
        return null;
      }
    } finally {}
  }

  Future<String> editBooking(
    String productSku,
    String warrantyCenter,
    DateTime bookingDate,
    String bookingTime,
    DateTime createAt,
    String maintenanceId,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');

    final data = jsonEncode({
      "maintenance": {
        "productSku": productSku,
        "bookingDate": bookingDate.toIso8601String(),
        "bookingTime": bookingTime,
        "warrantyCenter": warrantyCenter,
        "createdAt": createAt.toIso8601String(),
        "active": true
      }
    });

    print(data);

    try {
      var res = await http.put(
        '$baseUrl/maintenance/$maintenanceId',
        body: data,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token"
        },
      );
      print(res.statusCode);
      if (res.statusCode == 200) {
        print("success");
        return res.body;
      } else {
        return null;
      }
    } finally {}
  }
}
