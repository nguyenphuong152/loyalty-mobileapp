import 'package:loyalty_app/src/services/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:loyalty_app/models/point_model.dart';

class PointTransferBloc {
  final _repository = Repository();
  final _pointTransferFetcher = PublishSubject<ListPointTransferModel>();

  Stream<ListPointTransferModel> get pointTransfer =>
      _pointTransferFetcher.stream;

  fetchPointTransfer() async {
    if (!_pointTransferFetcher.isClosed) {
      print("fetch points");
      ListPointTransferModel pointTransferModel =
          await _repository.fetchPointTransfer();
      _pointTransferFetcher.sink.add(pointTransferModel);
    }
  }

  dispose() {
    _pointTransferFetcher.close();
  }
}
