
import 'dart:math';

import 'package:flutter/material.dart';

class MeetUpHomeScreen extends StatefulWidget {
  @override
  MeetupHome createState() {

    return MeetupHome();
  }
  
}

class MeetupHome extends State<MeetUpHomeScreen>{
  List<CustomText> customList =[CustomText(key: ValueKey('1')),CustomText(key: ValueKey('2')),CustomText(key: ValueKey('3'))];

  shuffleList() {
    setState(() {
      customList.shuffle();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(children: customList),
    appBar: AppBar(title: Text('Meetup Home')),
    floatingActionButton: FloatingActionButton(onPressed: () {
      shuffleList();
    },
    tooltip: 'Shuffle List'),
    );
  }

}

class CustomText extends StatefulWidget {

  CustomText({Key key}) : super(key: key);
  @override
  CustomTextState createState() => CustomTextState();
  
}

class CustomTextState extends State<CustomText> {
  final List colors = [Colors.red,Colors.blue,Colors.black,Colors.brown,Colors.grey];
  Random random = Random();
  Color color;


  @override
  void initState() {
    color = colors[random.nextInt(colors.length)];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Displaying Text for color $color'),
      color: this.color,
      width: 150,
      );
  }
  
}