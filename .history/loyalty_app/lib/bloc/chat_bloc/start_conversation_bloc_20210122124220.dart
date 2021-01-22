import 'dart:convert';

import 'package:loyalty_app/providers/chat_api_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartConversationBloc {
  Future<String> startConversation() async {
    final res = await ChatApiProvider().startNewConversation();
    final data = jsonDecode(res) as Map<String, dynamic>;

    return data["conversationId"];
  }
}
