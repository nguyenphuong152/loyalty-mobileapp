import 'package:loyalty_app/providers/chat/conversation_provider.dart';
import 'package:loyalty_app/providers/chat/messages_provider.dart';
import 'package:provider/provider.dart';

import 'locator.dart';

List<SingleChildCloneableWidget> providers = [
  ChangeNotifierProvider(
    builder: (context) => locator<ConversationProvider>(),
  ),
  ChangeNotifierProvider(
    builder: (context) => locator<ChatMessageProvider>(),
  ),
];
