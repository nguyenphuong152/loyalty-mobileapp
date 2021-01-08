import 'package:loyalty_app/models/customer_model.dart';
import 'package:loyalty_app/src/services/repository.dart';
import 'package:rxdart/rxdart.dart';

class CardBloc {
  final _repository = Repository();
  final _customerFetcher = PublishSubject<CustomerModel>();

  Stream<CustomerModel> get customer => _customerFetcher.stream;

  fetchCustomer() async {
    print("fetch customer");
    CustomerModel customerModel = await _repository.fetchCustomerData();
    _customerFetcher.sink.add(customerModel);
  }

  dispose() {
    _customerFetcher.close();
  }
}

final cardBloc = CardBloc();
