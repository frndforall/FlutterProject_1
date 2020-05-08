 import 'package:flutter/cupertino.dart';

class AppStore extends StatefulWidget {
  final Widget child;

  AppStore({@required this.child});
  @override
  AppStoreState createState() => AppStoreState();
  
}


class AppStoreState extends State<AppStore> {
  @override
  Widget build(BuildContext context) {
    return _InherittedAppState(
      child: widget.child,
    );
  }
  
}

class _InherittedAppState extends InheritedWidget {

  _InherittedAppState({@required Widget child}) : super(child: child);
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
  
}