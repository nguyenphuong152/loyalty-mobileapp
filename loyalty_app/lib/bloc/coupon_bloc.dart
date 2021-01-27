import 'package:loyalty_app/models/coupons_model.dart';
import 'package:loyalty_app/src/services/repository.dart';
import 'package:rxdart/rxdart.dart';

class CouponBloc {
  final _repository = Repository();
  final _customerCouponFetcher = PublishSubject<ListCouponModel>();

  Stream<ListCouponModel> get customerCoupon => _customerCouponFetcher.stream;

  buyCoupon(String couponId) async {
    print("fetch status");
    String res = await _repository.buyCoupon(couponId);
    print("bought: " + res);
  }

  fetchCustomerCoupon() async {
    if (!_customerCouponFetcher.isClosed) {
      print("fetch cus coupon bought");
      ListCouponModel couponModel = await _repository.fetchCustomerCoupon();
      print(couponModel.total);
      _customerCouponFetcher.sink.add(couponModel);
    }
  }

  dispose() {
    _customerCouponFetcher.close();
  }
}
