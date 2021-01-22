import 'dart:convert';
import 'dart:io';

import 'package:loyalty_app/constant.dart';
import 'package:loyalty_app/models/chat/chat_message_model.dart';
import 'package:loyalty_app/models/chat/conversation_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ChatApiProvider {
  Future<String> startNewConversation() async {
    final prefs = await SharedPreferences.getInstance();
    String customerId = prefs.getString('customerId');
    String name = prefs.getString('name');
    String token = prefs.getString('token');

    final data = jsonEncode({
      "conversation": {
        "participantIds": ["22200000-0000-474c-b092-b0dd880c07e2", customerId],
        "participantNames": ["admin", name],
        "lastMessageSnippet": "start",
        "lastMessageTimestamp": DateTime.now().toIso8601String()
      }
    });

    try {
      var res = await http.post(
        '$baseUrl/chat/conversation',
        body: data,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token"
        },
      );
      print(res.statusCode);
      if (res.statusCode == 200) {
        print("success");
        return res.body;
      } else {
        return null;
      }
    } finally {}
  }

  Future<http.Response> getConversation() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    try {
      var res = await http.post(
        '$baseUrl/chat/customer/conversation',
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token"
        },
      );
      return res;
    } finally {}
  }

  // Future<http.Response> storeMessage(MessageModal message) async {
  //   return await api.httpPost('messages', {
  //     'body': message.body,
  //     'conversation_id': message.conversationId.toString()
  //   });
  // }

  // Future<void> sendChatMessage(ChatMessageModel chatMessage) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   String name = prefs.getString('name');
  //   String token = prefs.getString('token');
  //   String conversationId = prefs.getString('conversationId');

  //   final data = jsonEncode({
  //     "message": {
  //       "conversationId": conversationId,
  //       "participantIds": [
  //         "22200000-0000-474c-b092-b0dd880c07e2",
  //         chatMessage.senderId
  //       ],
  //       "senderId": chatMessage.senderId,
  //       "senderName": name,
  //       "message": chatMessage.message,
  //       "messageTimestamp": chatMessage.time
  //     }
  //   });

  //   try {
  //     var res = await http.post(
  //       '$baseUrl/chat/message',
  //       body: data,
  //       headers: {
  //         HttpHeaders.contentTypeHeader: "application/json",
  //         HttpHeaders.authorizationHeader: "Bearer $token"
  //       },
  //     );
  //     print(res.statusCode);
  //     if (res.statusCode == 200) {
  //       print("success");
  //       return res.body;
  //     } else {
  //       return null;
  //     }
  //   } finally {}
  // }
}
