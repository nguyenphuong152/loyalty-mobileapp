import 'package:loyalty_app/providers/chat/conversation_provider.dart';
import 'package:loyalty_app/providers/chat/messages_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'locator.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (context) => locator<ConversationProvider>()),
  ChangeNotifierProvider(create: (context) => locator<ChatMessageProvider>())
];
