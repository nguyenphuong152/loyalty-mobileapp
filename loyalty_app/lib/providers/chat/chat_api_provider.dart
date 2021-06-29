import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loyalty_app/constant.dart';
import 'package:loyalty_app/models/chat/chat_message_model.dart';
import 'package:mime/mime.dart';
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
      var res = await http.get(
        '$baseUrl/chat/customer/conversation',
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token"
        },
      );
      return res;
    } finally {}
  }

  Future<http.Response> getMessages() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    try {
      var res = await http.get(
        '$baseUrl/chat/customer/message',
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token"
        },
      );
      return res;
    } finally {}
  }

//test proto
  Future<String> sendChatMessage(
      ChatMessageModel chatMessage, PickedFile media) async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');

    print(chatMessage.conversationId);
    print(chatMessage.senderId);
    print(chatMessage.senderName);
    print(chatMessage.message);
    print(chatMessage.messageTimestamp);

    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Bearer " + token
    }; //

    final mimeTypeData =
        lookupMimeType(media.path, headerBytes: [0xFF, 0xD8]).split('/');

    final file = await http.MultipartFile.fromPath(
        'message[photoMessage]', media.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));

    var postUri = Uri.parse('$baseUrl/chat/message/photo');

    var request = new http.MultipartRequest("POST", postUri);

    request.headers.addAll(headers);

    request.fields['massage[conversationId]'] = chatMessage.conversationId;
    request.fields['massage[conversationParticipantIds][0]'] =
        "22200000-0000-474c-b092-b0dd880c07e2";
    request.fields['massage[conversationParticipantIds][1]'] =
        chatMessage.senderId;
    request.fields['massage[senderId]'] = chatMessage.senderId;
    request.fields['massage[senderName]'] = chatMessage.senderName;
    request.fields['massage[message]'] = chatMessage.message;
    request.files.add(file);
    request.fields['massage[messageTimestamp]'] = chatMessage.messageTimestamp;

    var response = await request.send();
    // listen for response

    var res = await http.Response.fromStream(response);
    print(res);
    return json.decode(res.body);
  }

  Future<http.Response> updateConversation(ChatMessageModel chatMessage) async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    String customerId = prefs.getString('customerId');
    String name = prefs.getString('name');
    final data = jsonEncode({
      "conversation": {
        // "participantIds": ["22200000-0000-474c-b092-b0dd880c07e2", customerId],
        // "participantNames": ["admin", name],
        "lastMessageSnippet": chatMessage.message,
        "lastMessageTimestamp": chatMessage.messageTimestamp
      }
    });
    var id = chatMessage.conversationId;
    var res = await http.put(
      '$baseUrl/chat/conversation/$id',
      body: data,
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token"
      },
    );
    return res;
  }
}
