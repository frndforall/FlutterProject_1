import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myhomeapp/src/screens/meetup_home_screen.dart';
import 'package:myhomeapp/src/screens/posts_screen.dart';
import 'package:myhomeapp/widgets/bottom_navigation_design.dart';


class HomeScreen extends StatefulWidget{
  final String title;
  HomeScreen({this.title}); 
  @override
  State<StatefulWidget> createState() => HomeScreenState();
  

}

class HomeScreenState extends State<HomeScreen>   {
  final StreamController<int> _streamController = StreamController<int>();
  final StreamController<int> _counterController = StreamController<int>.broadcast();

  int increment =0;

  @override
  initState() {
    super.initState();
    _streamController.stream.listen((data) {
        increment = increment + data;
        _counterController.sink.add(increment);
        print(increment);
    });
  }

  @override
  dispose() {
    _streamController.close();
    _counterController.close();
    super.dispose();
  }

  _increment() {
            // increment++;
            // setState(() {
            //     increment++;
            // });
            _streamController.sink.add(10);
            
        }

  Widget build(BuildContext context) {
   return Scaffold(body: Center(child: Column(
     mainAxisAlignment:MainAxisAlignment.center,
     children: <Widget>[Text('Welcome to Business App',textDirection: TextDirection.ltr,style:TextStyle(fontSize: 30.0)
     ),

      StreamBuilder(stream: _counterController.stream,
      builder: (BuildContext context, AsyncSnapshot<int>  snapshot) {
          if(snapshot.hasData) {
            return Text('Counter is : ${snapshot.data}',
                 textDirection: TextDirection.ltr,
                style:TextStyle(fontSize: 24.0)
                );
          } else {
            return  Text('Counter is bad',
                 textDirection: TextDirection.ltr,
                style:TextStyle(fontSize: 24.0)
                );
          }
      },),
       RaisedButton(
         child:  StreamBuilder(stream: _counterController.stream,
      builder: (BuildContext context, AsyncSnapshot<int>  snapshot) {
          if(snapshot.hasData) {
            return Text('Counter is : ${snapshot.data}',
                 textDirection: TextDirection.ltr,
                style:TextStyle(fontSize: 24.0)
                );
          } else {
            return  Text('Counter is bad',
                 textDirection: TextDirection.ltr,
                style:TextStyle(fontSize: 24.0)
                );
          }
      },),
         onPressed: (){
           Navigator.pushNamed(context, MeetUpHomeScreen.route);
         },
       ), RaisedButton(
         child: Text('Go To Post Screen'),
         onPressed: (){
           Navigator.pushNamed(context, PostScreen.route);
         },
       )
       ],
   )
        ),
        floatingActionButton: FloatingActionButton(onPressed: _increment,
        child: Icon(Icons.add),
        tooltip: 'Click to increase'),
          appBar: AppBar(title:Text(widget.title)),
          bottomNavigationBar: BottomNavigation()
        );
  }

}
