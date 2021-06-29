import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
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

  PickedFile imageFile;
  final ImagePicker picker = ImagePicker();

  //1-cam 2-gallery

  @override
  void initState() {
    super.initState();
    message = ChatMessageModel();

    message.conversationId = widget.chatMessages[0].conversationId;
    message.senderId = widget.customerId;
    message.senderName = widget.customerName;

//  userId: user_id,
//       customerId: cusId,
//       messId: messId,
//       time: lastTime,
//       type: media/text???
    // channel.stream.listen((data) {
    //   ChatMessageSocketModel mess =
    //       ChatMessageSocketModel.fromJson(json.decode(data));
    //   setState(() {
    //     if (mess.from == "Me" || mess.customerId == widget.customerId) {
    //       messageList.add(mess);
    //       SchedulerBinding.instance.addPostFrameCallback((_) {
    //         _scrollController.animateTo(
    //           _scrollController.position.maxScrollExtent,
    //           duration: Duration(milliseconds: 500),
    //           curve: Curves.fastOutSlowIn,
    //         );
    //       });
    //     }
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey[50],
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: mPrimaryColor,
                size: subhead,
              ),
              onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                  "/home", (Route<dynamic> route) => false)),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'Hỗ trợ trực tuyến',
            style: TextStyle(
              fontSize: subhead,
              color: Colors.black,
              fontWeight: FontWeight.w500,
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
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
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
                    style: TextStyle(fontSize: footnote),
                    controller: messageTextEditController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Hãy viết gì đó ..."),
                  )),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: ((builder) => bottomSheet()),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: mPrimaryColor,
                      ),
                      child: FaIcon(FontAwesomeIcons.camera,
                          color: Colors.white, size: footnote),
                    ),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  InkWell(
                    onTap: _sendMessage,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: mPrimaryColor,
                      ),
                      child: FaIcon(FontAwesomeIcons.paperPlane,
                          color: Colors.white, size: footnote),
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

    message.message = messageTextEditController.text.trim();
    message.messageTimestamp = DateTime.now().toString();

    var messID = await Provider.of<ConversationProvider>(
      context,
    ).storeMessage(message, imageFile);

    // if (messageTextEditController.text.isNotEmpty) {
    //   ChatMessageSocketModel mess = new ChatMessageSocketModel();
    //   mess.userId = userId;
    //   mess.customerId = cusId;
    //   mess.msg = messageTextEditController.text;
    //   mess.time = current;

    //   var jsonString = json.encode(mess.toJson());

    //   channel.sink.add(jsonString);
    // }

    messageTextEditController.clear();

    //Provider.of<ConversationProvider>(context).updateConversation(message);
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

  void _openGallary(ImageSource source) async {
    final media = await picker.getImage(source: source);

    this.setState(() {
      imageFile = media;
    });

    _sendMessage();
  }

  Widget bottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Text("Chọn ảnh hoặc video"),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FlatButton.icon(
                  onPressed: () => _openGallary(ImageSource.camera),
                  icon: Icon(Icons.camera),
                  label: Text("Camera")),
              FlatButton.icon(
                  onPressed: () => _openGallary(ImageSource.gallery),
                  icon: Icon(Icons.collections),
                  label: Text("Thư viện"))
            ],
          )
        ],
      ),
    );
  }

  void addChatToSocket() {}

  @override
  void dispose() {
    messageTextEditController.dispose();
    channel.sink.close();
    super.dispose();
  }
}
