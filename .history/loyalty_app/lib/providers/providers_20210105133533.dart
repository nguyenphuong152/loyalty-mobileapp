import 'package:flutter/material.dart';
import 'package:loyalty_app/bloc/authen_bloc.dart';

class Provider extends InheritedWidget {
  final bloc = new AuthenBloc();
  // constructor, forward to Parent InheritedWidget
  Provider({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget _) {
    // Todo implantation
    return true;
  }

  static AuthenBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType() as Provider).bloc;
  }
}
