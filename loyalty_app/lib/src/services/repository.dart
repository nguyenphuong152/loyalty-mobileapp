import 'package:loyalty_app/models/customer_model.dart';
import 'package:loyalty_app/models/transaction_model.dart';
import 'package:loyalty_app/providers/customer_api_provider.dart';

class Repository {
  final customerApiProvider = CustomerApiProvider();

  Future<CustomerModel> fetchCustomerData() =>
      customerApiProvider.fetchCustomerData();

  Future<ListTransactionModel> fetchTransactions() =>
      customerApiProvider.fetchTransactions();
}
