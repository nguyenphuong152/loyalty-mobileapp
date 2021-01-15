import 'package:loyalty_app/models/maintenance_model.dart';
import 'package:loyalty_app/providers/customer_api_provider.dart';
import 'package:loyalty_app/src/services/repository.dart';
import 'package:rxdart/rxdart.dart';

class MaintenanceBookingBloc {
  final _repository = Repository();
  final _maintenanceBookFetcher = PublishSubject<ListMaintenanceModel>();

  Stream<ListMaintenanceModel> get maintenanceBook =>
      _maintenanceBookFetcher.stream;

  fetchListMaintenanceBook() async {
    if (!_maintenanceBookFetcher.isClosed) {
      print("fetch points");
      ListMaintenanceModel maintenanceBookModel =
          await _repository.fetchCustomerMaintenanceBooking();
      _maintenanceBookFetcher.sink.add(maintenanceBookModel);
    }
  }

  Future<String> booking(
    String productSku,
    String warrantyCenter,
    DateTime bookingDate,
    String bookingTime,
    DateTime createAt,
  ) async {
    print("booking bloc");

    final res = await CustomerApiProvider().booking(
        productSku, warrantyCenter, bookingDate, bookingTime, createAt);
    print(res.toString());
    return res;
  }

  Future<String> editBooking(
    String maintenanceId,
    String productSku,
    String warrantyCenter,
    DateTime bookingDate,
    String bookingTime,
    DateTime createAt,
  ) async {
    print("edit booking bloc");

    final res = await CustomerApiProvider().editBooking(productSku,
        warrantyCenter, bookingDate, bookingTime, createAt, maintenanceId);
    print(res.toString());
    return res;
  }

  dispose() {
    _maintenanceBookFetcher.close();
  }
}
