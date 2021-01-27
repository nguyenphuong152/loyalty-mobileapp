class ConversationModel {
  String conversationId;
  List<String> participantIds;
  List<String> participantNames;
  String lastMessageSnippet;
  DateTime lastMessageTimeStamp;

  ConversationModel(
      {this.conversationId,
      this.participantIds,
      this.participantNames,
      this.lastMessageSnippet,
      this.lastMessageTimeStamp});

  ConversationModel.fromJson(Map<String, dynamic> json) {
    conversationId = json['conversationId'];
    for (int i = 0; i < 2; i++) {
      participantIds[i] = json['participantIds'][i];
    }
    for (int i = 0; i < 2; i++) {
      participantIds[i] = json['participantNames'][i];
    }
    lastMessageSnippet = json['lastMessageSnippet'];
    lastMessageTimeStamp = json['lastMessageTimestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['conversationId'] = this.conversationId;
    for (int i = 0; i < 2; i++) {
      data['participantIds'][i] = this.participantIds[i];
    }
    for (int i = 0; i < 2; i++) {
      data['participantNames'][i] = this.participantNames[i];
    }
    data['lastMessageSnippet'] = this.lastMessageSnippet;
    data['lastMessageTimestamp'] = this.lastMessageTimeStamp;

    return data;
  }
}
