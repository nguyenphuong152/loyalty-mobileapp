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
