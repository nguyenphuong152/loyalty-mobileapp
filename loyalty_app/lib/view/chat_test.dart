import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loyalty_app/constant.dart';
import 'package:loyalty_app/models/chat/chat_message_model.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatTest extends StatefulWidget {
  final WebSocketChannel channel = IOWebSocketChannel.connect(webSocket);
  @override
  _ChatTestState createState() => _ChatTestState(channel: channel);
}

class _ChatTestState extends State<ChatTest> {
  final WebSocketChannel channel;
  final inputController = TextEditingController();
  List<ChatMessageSocketModel> messageList = [];

  _ChatTestState({this.channel}) {
    channel.stream.listen((data) {
      setState(() {
        print(data);
        messageList.add(ChatMessageSocketModel.fromJson(json.decode(data)));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Form(
              child: TextFormField(
                controller: inputController,
                decoration: InputDecoration(
                  labelText: 'Send Message',
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(fontSize: 22),
              ),
            ),
          ),
          Expanded(
            child: getMessageList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Send message',
        child: Icon(Icons.send),
      ), //
    );
  }

  void _sendMessage() {
    DateTime now = DateTime.now();
    String current = "${now.hour.toString()}:${now.minute.toString()}";
    var userId = "11111111-0000-474c-b092-b0dd880c07e1";
    var cusId = "22200000-0000-474c-b092-b0dd880c07e2";

    if (inputController.text.isNotEmpty) {
      ChatMessageSocketModel mess = new ChatMessageSocketModel();
      mess.userId = userId;
      mess.customerId = cusId;
      mess.msg = inputController.text;
      mess.time = current;

      var jsonString = json.encode(mess.toJson());

      inputController.text = "";

      channel.sink.add(jsonString);
    }
  }

  ListView getMessageList() {
    List<Widget> listWidget = [];

    for (ChatMessageSocketModel message in messageList) {
      listWidget.add(ListTile(
        title: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              message.msg,
              style: TextStyle(fontSize: 22),
            ),
          ),
          color: message.from == 'Me' ? Colors.teal[50] : Colors.amber[50],
          height: 60,
        ),
      ));
    }

    return ListView(children: listWidget);
  }

  @override
  void dispose() {
    inputController.dispose();
    widget.channel.sink.close();
    super.dispose();
  }
}
