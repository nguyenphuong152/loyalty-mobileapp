import 'dart:convert';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
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
      notifyListeners();
      setBusy(false);
    }
    return _conversation;
  }

  Future<List<ChatMessageModel>> getMessages() async {
    print("conversation prodivder: " + _messages.length.toString());

    if (_messages.isNotEmpty) return _messages;
    setBusy(true);
    var response = await _chatApiProvider.getMessages();
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      data['messages']
          .forEach((mess) => _messages.add(ChatMessageModel.fromJson(mess)));
      notifyListeners();
      setBusy(false);
    }
    return _messages;
  }

  Future<String> storeMessage(ChatMessageModel message, String media) async {
    setBusy(true);
    var response = await _chatApiProvider.sendChatMessage(message, media);
    print(response);
    if (response != null) {
      // var data = jsonDecode(response.body);
      setBusy(false);
      addMessageToConversation(message);
      return (response);
    }
    setBusy(false);
    return null;
  }

  Future<String> storeMessageText(ChatMessageModel message) async {
    setBusy(true);
    var response = await _chatApiProvider.sendChatMessageText(message);
    print(response);
    if (response != null) {
      // var data = jsonDecode(response.body);
      setBusy(false);
      addMessageToConversation(message);
      return (response);
    }
    setBusy(false);
    return null;
  }

  addMessageToConversation(ChatMessageModel message) async {
    _messages.add(message);
    notifyListeners();
  }

  Future<String> updateConversation(ChatMessageModel message) async {
    setBusy(true);
    var response = await _chatApiProvider.updateConversation(message);
    if (response.statusCode == 200) {
      // var data = jsonDecode(response.body);
      setBusy(false);
      return (response.body);
    }
    setBusy(false);
    return null;
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
