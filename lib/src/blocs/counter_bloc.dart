

import 'dart:async';

import 'package:flutter/material.dart';

class CounterBloc {

  int increment =0;
  final StreamController<int> _streamController = StreamController<int>();
  final StreamController<int> _counterController = StreamController<int>.broadcast();

  dispose() {
    _streamController.close();
    _counterController.close();
  }

  void incrementer(int incrementer) {
      _streamController.sink.add(incrementer);
  }

CounterBloc() {
  _streamController.stream.listen((data) {
        increment = increment + data;
        coutersink.add(increment);
        print(increment);
    });
}

Stream<int> get counterstream => _counterController.stream;
Sink<int> get coutersink => _counterController.sink;




}


class CounterBlocProvider extends StatefulWidget {
  final CounterBloc bloc;
  final Widget child;

  CounterBlocProvider({Key key, @required this.child})
    : bloc = CounterBloc(),
      super(key: key);

  _CounterBlocProviderState createState() => _CounterBlocProviderState();

   static CounterBloc of(BuildContext context) {
    _CounterBlocProviderInherited provider =
      (context.getElementForInheritedWidgetOfExactType<_CounterBlocProviderInherited>()?.widget
     as _CounterBlocProviderInherited);

    return provider.bloc;
  }
}

class _CounterBlocProviderState extends State<CounterBlocProvider> {

  Widget build(BuildContext context) {
    return _CounterBlocProviderInherited(
      child: widget.child,
      bloc: widget.bloc
    );
  }

  dispose() {
    widget.bloc.dispose();
    super.dispose();
  }
}

class _CounterBlocProviderInherited extends InheritedWidget {

  final CounterBloc bloc;

   _CounterBlocProviderInherited({@required Widget child, @required this.bloc, Key key})
    : super(key: key, child: child);

  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  // static CounterBloc of(BuildContext context) {
  //   return (context.dependOnInheritedWidgetOfExactType<CounterBlocProvider> ()).bloc;
  // }
}