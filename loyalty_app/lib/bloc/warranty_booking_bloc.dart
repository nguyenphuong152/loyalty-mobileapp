import 'package:loyalty_app/models/warranty_model.dart';
import 'package:loyalty_app/providers/customer_api_provider.dart';
import 'package:loyalty_app/src/services/repository.dart';
import 'package:rxdart/rxdart.dart';

class WarrantyBookingBloc {
  final _repository = Repository();
  final _warrantyBookFetcher = PublishSubject<ListWarrantyModel>();

  Stream<ListWarrantyModel> get warrantyBook => _warrantyBookFetcher.stream;

  fetchListWarrantyBook() async {
    if (!_warrantyBookFetcher.isClosed) {
      print("fetch points");
      ListWarrantyModel warrantyBookModel =
          await _repository.fetchCustomerWarrantyBooking();
      _warrantyBookFetcher.sink.add(warrantyBookModel);
    }
  }

  Future<String> bookingWarranty(
    String productSku,
    String warrantyCenter,
    DateTime bookingDate,
    String bookingTime,
    DateTime createAt,
  ) async {
    final res = await CustomerApiProvider().bookingWarranty(
        productSku, warrantyCenter, bookingDate, bookingTime, createAt);
    return res;
  }

  Future<String> editBooking(
    String productSku,
    String warrantyCenter,
    DateTime bookingDate,
    String bookingTime,
    DateTime createAt,
    String maintenanceId,
    String discription,
    String cost,
    String paymentStatus,
  ) async {
    final res = await CustomerApiProvider().editBookingWarranty(
        productSku,
        warrantyCenter,
        bookingDate,
        bookingTime,
        createAt,
        maintenanceId,
        discription,
        cost,
        paymentStatus);
    return res;
  }

  dispose() {
    _warrantyBookFetcher.close();
  }
}
