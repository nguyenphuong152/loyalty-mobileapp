import 'package:loyalty_app/models/transaction_model.dart';
import 'package:loyalty_app/src/services/repository.dart';
import 'package:rxdart/rxdart.dart';

class TransactionBloc {
  final _repository = Repository();
  final _transactionFetcher = PublishSubject<ListTransactionModel>();

  Stream<ListTransactionModel> get transactions => _transactionFetcher.stream;

  fetchTransactions() async {
    if (!_transactionFetcher.isClosed) {
      print("fetch transaction");
      ListTransactionModel transactionModel =
          await _repository.fetchTransactions();
      _transactionFetcher.sink.add(transactionModel);
    }
  }

  dispose() {
    _transactionFetcher.close();
  }
}
