import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loyalty_app/constant.dart';
import 'package:loyalty_app/models/chat/chat_message_model.dart';
import 'package:loyalty_app/view/support/components/moderator_card.dart';
import 'package:loyalty_app/view/support/components/my_message_card.dart';

class SupportingScreen extends StatefulWidget {
  final String customerId;
  final List<ChatMessageModel> chatMessages;
  SupportingScreen(this.customerId, this.chatMessages);

  @override
  _SupportingScreenState createState() => _SupportingScreenState();
}

class _SupportingScreenState extends State<SupportingScreen> {
  ScrollController _scrollController = ScrollController();
  ChatMessageModel message;
  List<ChatMessageModel> listMessage;

  @override
  void initState() {
    super.initState();
    message = ChatMessageModel();
    print("lenght" + widget.chatMessages.length.toString());
    listMessage = [...widget.chatMessages];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
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
                child: ListView.builder(
                    controller: _scrollController,
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    itemCount: listMessage.length,
                    itemBuilder: (context, index) =>
                        listMessage[index].senderId == widget.customerId
                            ? MyMessageCard(
                                message: listMessage[index],
                              )
                            : ModeratorCard(
                                message: listMessage[index],
                              ))),
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
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Hãy viết gì đó ..."),
                  )),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: mPrimaryColor,
                    ),
                    child: FaIcon(FontAwesomeIcons.paperPlane,
                        color: Colors.white),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
