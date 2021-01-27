import 'package:loyalty_app/models/coupons_model.dart';
import 'package:loyalty_app/models/customer_model.dart';
import 'package:loyalty_app/models/maintenance_model.dart';
import 'package:loyalty_app/models/transaction_model.dart';
import 'package:loyalty_app/models/point_model.dart';
import 'package:loyalty_app/models/campaign_model.dart';
import 'package:loyalty_app/providers/customer_api_provider.dart';

class Repository {
  final customerApiProvider = CustomerApiProvider();

  Future<CustomerModel> fetchCustomerData() =>
      customerApiProvider.fetchCustomerData();

  Future<ListTransactionModel> fetchTransactions() =>
      customerApiProvider.fetchTransactions();

  Future<CustomerStatusModel> fetchCustomerStatus() =>
      customerApiProvider.fetchCustomerStatus();

  Future<ListPointTransferModel> fetchPointTransfer() =>
      customerApiProvider.fetchCustomerPointTransfer();

  Future<ListCampaignModel> fetchCustomerCampaign() =>
      customerApiProvider.fetchCustomerCampaign();

  dynamic buyCoupon(String couponId) => customerApiProvider.buyCoupon(couponId);

  Future<ListCouponModel> fetchCustomerCoupon() =>
      customerApiProvider.fetchCustomerCoupon();

  Future<ListMaintenanceModel> fetchCustomerMaintenanceBooking() =>
      customerApiProvider.fetchCustomerMaintenanceBooking();

  // Future<Main> fetchCustomerMaintenanceBooking() =>
  // customerApiProvider.fetchCustomerMaintenanceBooking();
}
