import 'package:flutter/material.dart';
import 'package:loyalty_app/bloc/chat_bloc/start_conversation_bloc.dart';
import 'package:loyalty_app/constant.dart';
import 'package:loyalty_app/models/chat/chat_message_model.dart';
import 'package:loyalty_app/providers/chat/conversation_provider.dart';
import 'package:loyalty_app/view/support/supporting_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartConverstionScreen extends StatefulWidget {
  @override
  _StartConverstionScreenState createState() => _StartConverstionScreenState();
}

class _StartConverstionScreenState extends State<StartConverstionScreen> {
  StartConversationBloc startConversationBloc = StartConversationBloc();
  List<ChatMessageModel> _listChatMess;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      width: 300,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(color: mPrimaryColor, width: 2.0)),
        color: Colors.white,
        textColor: mPrimaryColor,
        onPressed: () async {
          final prefs = await SharedPreferences.getInstance();
          String customerId = prefs.getString('customerId');
          String name = prefs.getString('name');
          var value = await startConversationBloc.startConversation();
          _listChatMess =
              await Provider.of<ConversationProvider>(context).getMessages();
          if (value.isNotEmpty) {
            print(_listChatMess);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return SupportingScreen(customerId, _listChatMess, name);
                },
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "Bắt đầu cuộc trò chuyện với nhân viên hỗ trợ",
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ));
  }
}
