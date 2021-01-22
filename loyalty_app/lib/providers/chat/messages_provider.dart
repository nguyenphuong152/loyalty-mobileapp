import 'package:loyalty_app/models/chat/chat_message_model.dart';
import 'package:loyalty_app/providers/chat/base_provider.dart';
import 'package:loyalty_app/providers/chat/chat_api_provider.dart';

class ChatMessageProvider extends BaseProvider {
  List<ChatMessageModel> _chatmessages = List();
  List<ChatMessageModel> get chatmessages => _chatmessages;
  ChatApiProvider _chatApiProvider = ChatApiProvider();

  Future<List<ChatMessageModel>> getChatMessage() async {
    if (_chatmessages != null) return _chatmessages;
    setBusy(true);
    var response = await _chatApiProvider.getMessages();

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      data['messages'].forEach(
          (mess) => _chatmessages.add(ChatMessageModel.fromJson(mess)));
      print(response.body);
      notifyListeners();
      setBusy(false);
    }
    return _chatmessages;
  }

  jsonDecode(body) {}
}
