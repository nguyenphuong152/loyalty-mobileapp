import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loyalty_app/bloc/chat_bloc/supporting_screen_bloc.dart';
import 'package:loyalty_app/constant.dart';
import 'package:loyalty_app/models/chat/chat_message_model.dart';
import 'package:loyalty_app/providers/chat/conversation_provider.dart';
import 'package:loyalty_app/view/support/components/moderator_card.dart';
import 'package:loyalty_app/view/support/components/my_message_card.dart';
import 'package:provider/provider.dart';

class SupportingScreen extends StatefulWidget {
  final String customerId;
  final List<ChatMessageModel> chatMessages;
  final String customerName;
  SupportingScreen(this.customerId, this.chatMessages, this.customerName);

  @override
  _SupportingScreenState createState() => _SupportingScreenState();
}

class _SupportingScreenState extends State<SupportingScreen> {
  SupportingScreenBloc supportingScreenBloc = SupportingScreenBloc();
  ScrollController _scrollController = ScrollController();
  TextEditingController messageTextEditController = TextEditingController();
  ChatMessageModel message;
  List<ChatMessageModel> listMessage;

  @override
  void initState() {
    super.initState();
    message = ChatMessageModel();
    print("lenght" + widget.chatMessages.length.toString());
    listMessage = [...widget.chatMessages];
    message.conversationId = listMessage[0].conversationId;
    message.senderId = widget.customerId;
    message.senderName = widget.customerName;
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
                    controller: messageTextEditController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Hãy viết gì đó ..."),
                  )),
                  Provider.of<ConversationProvider>(context).busy
                      ? CircularProgressIndicator()
                      : InkWell(
                          onTap: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            if (messageTextEditController.text.isEmpty) return;
                            message.message =
                                messageTextEditController.text.trim();
                            message.messageTimestamp =
                                DateTime.now().toString();
                            print(message.toJson());
                            await Provider.of<ConversationProvider>(
                              context,
                            ).storeMessage(message);
                            messageTextEditController.clear();
                            _scrollController.jumpTo(
                                _scrollController.position.maxScrollExtent +
                                    23);
                          },
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
}
