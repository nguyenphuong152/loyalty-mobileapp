import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loyalty_app/constant.dart';
import 'package:loyalty_app/models/chat/chat_message_model.dart';
import 'package:loyalty_app/providers/chat/conversation_provider.dart';
import 'package:loyalty_app/view/support/components/moderator_card.dart';
import 'package:loyalty_app/view/support/components/my_message_card.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class SupportingScreen extends StatefulWidget {
  final String customerId;
  final List<ChatMessageModel> chatMessages;
  final String customerName;

  SupportingScreen(this.customerId, this.chatMessages, this.customerName);

  @override
  _SupportingScreenState createState() => _SupportingScreenState();
}

class _SupportingScreenState extends State<SupportingScreen> {
  ScrollController _scrollController = ScrollController();
  TextEditingController messageTextEditController = TextEditingController();
  ChatMessageModel message;
  final WebSocketChannel channel = IOWebSocketChannel.connect(webSocket);
  List<ChatMessageSocketModel> messageList = [];

  @override
  void initState() {
    super.initState();
    message = ChatMessageModel();

    message.conversationId = widget.chatMessages[0].conversationId;
    message.senderId = widget.customerId;
    message.senderName = widget.customerName;

    channel.stream.listen((data) {
      ChatMessageSocketModel mess =
          ChatMessageSocketModel.fromJson(json.decode(data));
      setState(() {
        if (mess.from == "Me" || mess.customerId == widget.customerId) {
          messageList.add(mess);
          SchedulerBinding.instance.addPostFrameCallback((_) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn,
            );
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () => Navigator.of(context).pop()),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'Hỗ trợ trực tuyến',
            style: TextStyle(
              fontSize: mFontSize,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: getMessageList(),
            )),
            Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  border: Border.all(color: mPrimaryColor),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                      child: TextField(
                    controller: messageTextEditController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Hãy viết gì đó ..."),
                  )),
                  Provider.of<ConversationProvider>(context).busy
                      ? CircularProgressIndicator()
                      : InkWell(
                          onTap: _sendMessage,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: mPrimaryColor,
                            ),
                            child: FaIcon(FontAwesomeIcons.paperPlane,
                                color: Colors.white),
                          ),
                        )
                ],
              ),
            )
          ],
        ));
  }

  void _sendMessage() async {
    DateTime now = DateTime.now();
    String current = "${now.hour.toString()}:${now.minute.toString()}";
    var userId = message.senderId;
    var cusId = "22200000-0000-474c-b092-b0dd880c07e2";

    if (messageTextEditController.text.isNotEmpty) {
      ChatMessageSocketModel mess = new ChatMessageSocketModel();
      mess.userId = userId;
      mess.customerId = cusId;
      mess.msg = messageTextEditController.text;
      mess.time = current;

      var jsonString = json.encode(mess.toJson());

      channel.sink.add(jsonString);
    }

    message.message = messageTextEditController.text.trim();
    message.messageTimestamp = DateTime.now().toString();
    await Provider.of<ConversationProvider>(
      context,
    ).storeMessage(message);
    Provider.of<ConversationProvider>(context).updateConversation(message);

    messageTextEditController.clear();
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }

  ListView getMessageList() {
    List<Widget> listWidget = [];

    for (ChatMessageSocketModel message in messageList) {
      if (message.from == "Me") {
        listWidget.add(MyMessageCard(
          message: message.msg,
        ));
      } else {
        listWidget.add(ModeratorCard(
          message: message.msg,
        ));
      }
    }

    return ListView(
      children: listWidget,
      controller: _scrollController,
    );
  }

  @override
  void dispose() {
    messageTextEditController.dispose();
    channel.sink.close();
    super.dispose();
  }
}
