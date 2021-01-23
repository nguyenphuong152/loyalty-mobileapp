import 'package:loyalty_app/models/chat/chat_message_model.dart';
import 'package:loyalty_app/models/chat/conversation_model.dart';
import 'package:loyalty_app/providers/chat/base_provider.dart';
import 'package:loyalty_app/providers/chat/chat_api_provider.dart';

class ConversationProvider extends BaseProvider {
  ConversationModel _conversation;
  ConversationModel get conversation => _conversation;
  List<ChatMessageModel> _messages = List();
  List<ChatMessageModel> get messages => _messages;
  ChatApiProvider _chatApiProvider = ChatApiProvider();

  Future<ConversationModel> getConversation() async {
    if (_conversation != null) return _conversation;
    setBusy(true);
    var response = await _chatApiProvider.getConversation();

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      int numb = data['total'] - 1;
      _conversation = ConversationModel.fromJson(data['conversations'][numb]);
      print(response.body);
      notifyListeners();
      setBusy(false);
    }
    return _conversation;
  }

  Future<List<ChatMessageModel>> getMessages() async {
    if (_messages.isNotEmpty) return _messages;
    setBusy(true);
    var response = await _chatApiProvider.getMessages();
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print("mess" + data["0"]["total"]);
      // data['messages']
      //     .forEach((mess) => _messages.add(ChatMessageModel.fromJson(mess)));
      notifyListeners();
      setBusy(false);
    }
    return _messages;
  }

  Future<void> storeMessage(ChatMessageModel message) async {
    setBusy(true);
    var response = await _chatApiProvider.sendChatMessage(message);
    if (response.statusCode == 200) {
      // var data = jsonDecode(response.body);
      setBusy(false);
      addMessageToConversation(message);
    }
    setBusy(false);
  }

  addMessageToConversation(ChatMessageModel message) async {
    _messages.add(message);
    // toTheTop(message);
    notifyListeners();
  }

  toTheTop(ChatMessageModel mess) {
    var index = _messages.indexOf(mess);

    for (var i = index; i > 0; i--) {
      var x = _messages[i];
      _messages[i] = _messages[i - 1];
      _messages[i - 1] = x;
    }
  }

  jsonDecode(body) {}
}
