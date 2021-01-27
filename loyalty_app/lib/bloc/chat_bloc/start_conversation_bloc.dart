import 'dart:convert';

import 'package:loyalty_app/models/chat/chat_message_model.dart';
import 'package:loyalty_app/providers/chat/base_provider.dart';
import 'package:loyalty_app/providers/chat/chat_api_provider.dart';

class StartConversationBloc extends BaseProvider {
  List<ChatMessageModel> _chatmessages = List();

  Future<String> startConversation() async {
    final res = await ChatApiProvider().startNewConversation();
    final data = jsonDecode(res) as Map<String, dynamic>;

    return data["conversationId"];
  }

  Future<List<ChatMessageModel>> getChatMessage() async {
    if (_chatmessages.isNotEmpty) return _chatmessages;
    var response = await ChatApiProvider().getMessages();
    print(response.statusCode);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      data['messages'].forEach(
          (mess) => _chatmessages.add(ChatMessageModel.fromJson(mess)));
      notifyListeners();
    }
    return _chatmessages;
  }
}
