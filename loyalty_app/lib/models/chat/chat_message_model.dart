class ChatMessageModel {
  String conversationId;
  String messageId;
  String senderId;
  String senderName;
  String message;
  DateTime messageTimestamp;

  ChatMessageModel(
      {this.conversationId,
      this.message,
      this.messageId,
      this.messageTimestamp,
      this.senderId,
      this.senderName});

  ChatMessageModel.fromJson(Map<String, dynamic> json) {
    conversationId = json['conversationId'];
    messageId = json['messageId'];
    senderId = json['senderId'];
    senderName = json['senderName'];
    message = json['message'];
    messageTimestamp = json['messageTimestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['conversationId'] = this.conversationId;
    data['messageId'] = this.messageId;
    data['senderId'] = this.senderId;
    data['senderName'] = this.senderName;
    data['message'] = this.message;
    data['messageTimestamp'] = this.messageTimestamp;

    return data;
  }
}
