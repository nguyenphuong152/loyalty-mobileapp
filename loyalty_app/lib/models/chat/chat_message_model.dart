import 'package:flutter/foundation.dart';

class ChatMessageModel {
  String conversationId;
  String senderId;
  String senderName;
  String message;
  String messageTimestamp;

  ChatMessageModel(
      {this.conversationId,
      this.message,
      this.messageTimestamp,
      this.senderId,
      this.senderName});

  ChatMessageModel.fromJson(Map<String, dynamic> json) {
    conversationId = json['conversationId'];
    senderId = json['senderId'];
    senderName = json['senderName'];
    message = json['message'];
    messageTimestamp = json['messageTimestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['conversationId'] = this.conversationId;
    data['senderId'] = this.senderId;
    data['senderName'] = this.senderName;
    data['message'] = this.message;
    data['messageTimestamp'] = this.messageTimestamp;

    return data;
  }
}

class ChatMessageSocketModel {
  String userId;
  String customerId;
  String msg;
  String time;
  String from;

  ChatMessageSocketModel(
      {this.customerId, this.userId, this.msg, this.time, this.from});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['customerId'] = this.customerId;
    data['msg'] = this.msg;
    data['time'] = this.time;

    return data;
  }

  ChatMessageSocketModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    customerId = json['customerId'];
    msg = json['msg'];
    time = json['time'];
    from = json['from'];
  }
}
