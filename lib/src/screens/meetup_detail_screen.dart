
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myhomeapp/widgets/bottom_navigation_design.dart';

class MeetupDetailScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(children: <Widget>[Text('I am MeetupDetail Widget')]),

      ),
      appBar:AppBar(title:Text('Meetup Details')),
      bottomNavigationBar: BottomNavigation(),
    );
  }

}