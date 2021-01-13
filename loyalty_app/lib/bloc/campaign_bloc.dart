import 'package:loyalty_app/src/services/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:loyalty_app/models/campaign_model.dart';

class CampaignBloc {
  final _repository = Repository();
  final _campaignFetcher = PublishSubject<ListCampaignModel>();

  Stream<ListCampaignModel> get campaign => _campaignFetcher.stream;

  fetchCustomerCampaign() async {
    print("fetch campaign");
    ListCampaignModel campaignModel = await _repository.fetchCustomerCampaign();
    _campaignFetcher.sink.add(campaignModel);
  }

  dispose() {
    _campaignFetcher.close();
  }
}
