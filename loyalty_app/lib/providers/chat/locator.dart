import 'package:get_it/get_it.dart';
import 'package:loyalty_app/providers/chat/conversation_provider.dart';
import 'package:loyalty_app/providers/chat/messages_provider.dart';

GetIt locator = GetIt.instance;
void setupLocator() {
  locator.registerLazySingleton(() => ConversationProvider());
  locator.registerLazySingleton(() => ChatMessageProvider());
}
