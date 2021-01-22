import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:loyalty_app/models/chat/conversation_model.dart';
import 'package:loyalty_app/providers/chat/base_provider.dart';
import 'package:loyalty_app/providers/chat/chat_api_provider.dart';

class ConversationProvider extends BaseProvider {
  ConversationModel _conversation;
  ConversationModel get conversation => _conversation;

  Future<ConversationModel> getConversation() async {
    if (_conversation != null) return _conversation;
    setBusy(true);
    var response = await ChatApiProvider.getConversation();

    if (response.statusCode == 200) {
      _conversation = ConversationModel.fromJson(json.decode(response.body));
      print(response.body);
      notifyListeners();
      setBusy(false);
    }
    return _conversation;
  }

  jsonDecode(body) {}
}
