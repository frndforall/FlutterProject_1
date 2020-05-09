
import 'package:flutter/material.dart';

class MeetUpHomeScreen extends StatefulWidget {
  @override
  MeetupHome createState() {

    return MeetupHome();
  }
  
}

class MeetupHome extends State{
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Column(
      mainAxisAlignment:MainAxisAlignment.center,
      children: <Widget>[
      Text('I am meetup home scree',textDirection: TextDirection.ltr),
      Text('I am the second line in the screen',textAlign: TextAlign.right,)
    ],)
    ),
    appBar: AppBar(title: Text('Meetup Home'))
    );
  }

}