import 'package:loyalty_app/models/chat/chat_message_model.dart';
import 'package:loyalty_app/providers/chat/base_provider.dart';
import 'package:loyalty_app/providers/chat/chat_api_provider.dart';

class SupportingScreenBloc extends BaseProvider {
  Future<String> getMess(String messId) async {
    String content = await ChatApiProvider().getMess(messId);
    return content;
  }
}
