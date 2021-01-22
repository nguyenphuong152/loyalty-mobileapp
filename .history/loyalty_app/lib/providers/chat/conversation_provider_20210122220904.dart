import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:loyalty_app/models/chat/conversation_model.dart';
import 'package:loyalty_app/providers/chat/base_provider.dart';
import 'package:loyalty_app/providers/chat/chat_api_provider.dart';

class ConversationProvider extends BaseProvider {
  ConversationModel _conversation;
  ConversationModel get conversation => _conversation;
  ChatApiProvider _chatApiProvider = ChatApiProvider();

  Future<ConversationModel> getConversation() async {
    if (_conversation != null) return _conversation;
    setBusy(true);
    var response = await _chatApiProvider.getConversation();

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      _conversation = ConversationModel.fromJson(data['conversations'][0]);
      print(response.body);
      notifyListeners();
      setBusy(false);
    }
    return _conversation;
  }

  jsonDecode(body) {}
}
