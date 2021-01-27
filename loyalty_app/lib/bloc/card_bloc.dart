import 'package:loyalty_app/models/customer_model.dart';
import 'package:loyalty_app/src/services/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CardBloc {
  final _repository = Repository();
  final _customerFetcher = PublishSubject<CustomerModel>();

  Stream<CustomerModel> get customer => _customerFetcher.stream;

  fetchCustomer() async {
    if (!_customerFetcher.isClosed) {
      print("fetch customer");
      CustomerModel customerModel = await _repository.fetchCustomerData();

      final prefs = await SharedPreferences.getInstance();
      prefs.setString(
          'name', customerModel.lastName + " " + customerModel.firstName);
      prefs.setString('email', customerModel.email);
      prefs.setString('phone', customerModel.phone);
      prefs.setString('loyaltyCardNumber', customerModel.loyaltyCardNumber);

      _customerFetcher.sink.add(customerModel);
    }
  }

  dispose() {
    _customerFetcher.close();
  }
}
