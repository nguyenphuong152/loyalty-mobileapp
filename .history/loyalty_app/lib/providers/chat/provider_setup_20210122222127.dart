import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'locator.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(
    builder: (context) => locator<ConversationProvider>(),
  ),
];
