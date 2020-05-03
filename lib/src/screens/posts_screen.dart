import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    
    return _PostScreenState();
  }

}

class _PostScreenState extends State<PostScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Column(
                  children: <Widget>[
                    Text('Welcome to Post Screen',textDirection: TextDirection.ltr)
                  ],),
                  ),
                  appBar: AppBar(title: Text('Post Screen'),),);
  }

}