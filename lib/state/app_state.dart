 import 'package:flutter/cupertino.dart';

class AppStore extends StatefulWidget {
  final Widget child;

  AppStore({@required this.child});
  @override
  AppStoreState createState() => AppStoreState();
  
  static AppStoreState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_InherittedAppState>().data;
      
  }
}


class AppStoreState extends State<AppStore> {
  final String testData1 = 'testData 1';
    final String testData2 = 'testData 2';
    final String testData3 = 'testData 3';

  @override
  Widget build(BuildContext context) {
    return _InherittedAppState(
      child: widget.child,
      data: this
    );
  }
  
}

class _InherittedAppState extends InheritedWidget {
  AppStoreState data;
  _InherittedAppState({@required Widget child, this.data}) : super(child: child);
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
  
}