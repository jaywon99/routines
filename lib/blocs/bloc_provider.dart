
import 'package:flutter/material.dart';

abstract class BlocBase {
  void dispose();
}

// https://github.com/boeledi/Streams-Block-Reactive-Programming-in-Flutter
// Can inject bloc on widget tree! NICE IDEA!!!
class BlocProvider<T extends BlocBase> extends StatefulWidget {
  final T bloc;
  final Widget child;
  BlocProvider({Key key, @required this.child, @required this.bloc}) : super(key: key);

  @override
  _BlocProviderState<T> createState() => _BlocProviderState<T>();

  static T of<T extends BlocBase>(BuildContext context) {
    BlocProvider<T> provider = context.findAncestorWidgetOfExactType<BlocProvider<T>>(); 
    return provider.bloc;
  }
}

class _BlocProviderState<T> extends State<BlocProvider<BlocBase>> {
  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
