import 'package:loyalty_app/models/customer_model.dart';
import 'package:loyalty_app/src/services/repository.dart';
import 'package:rxdart/rxdart.dart';

class PointBloc {
  final _repository = Repository();
  final _customerStatusFetcher = PublishSubject<CustomerStatusModel>();

  Stream<CustomerStatusModel> get customerStatus =>
      _customerStatusFetcher.stream;

  fetchCustomerStatus() async {
    if (!_customerStatusFetcher.isClosed) {
      print("fetch status");
      CustomerStatusModel customerStatusModel =
          await _repository.fetchCustomerStatus();
      _customerStatusFetcher.sink.add(customerStatusModel);
    }
  }

  dispose() {
    _customerStatusFetcher.close();
  }
}
