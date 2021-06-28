import 'package:loyalty_app/src/services/repository.dart';
import 'package:loyalty_app/models/request_support_model.dart';

class SupportRequestBloc {
  final _repository = Repository();
  //final _pointTransferFetcher = PublishSubject<ListPointTransferModel>();

  // Stream<ListPointTransferModel> get pointTransfer =>
  //     _pointTransferFetcher.stream;

  // fetchPointTransfer() async {
  //   if (!_pointTransferFetcher.isClosed) {
  //     print("fetch points");
  //     ListPointTransferModel pointTransferModel =
  //         await _repository.fetchPointTransfer();
  //     _pointTransferFetcher.sink.add(pointTransferModel);
  //   }
  // }

  Future<String> sendSupport(RequestSupportModel request) async {
    final res = await _repository.sendRequest(request);
    return res;
  }

  // dispose() {
  //   _pointTransferFetcher.close();
  // }
}
