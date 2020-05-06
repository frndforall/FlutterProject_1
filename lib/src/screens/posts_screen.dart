import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'dart:convert';

class PostScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    
    return _PostScreenState();
  }

}

class _PostScreenState extends State<PostScreen>{
  List<dynamic> _postlist = [];

  @override
  void initState() { 
    super.initState();
    getPosts();
  }

  void getPosts() {
   http.get('https://jsonplaceholder.typicode.com/posts')
    .then((res){
      // print(res.body);
      final posts = json.decode(res.body);
      setState(() {
        _postlist = posts;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _PostList(_postlist),
                  appBar: AppBar(title: Text('Post Screen'),),
                  );
  }

}



class _PostList extends StatelessWidget {

List<dynamic> _postList;

_PostList(List<dynamic> list) {
  _postList = list;
}

@override
  Widget build(BuildContext context) {
    
    // return ListView(children: _postList.map((post){
    //                     return ListTile(
    //                       title: Text( post['title'],textDirection:TextDirection.ltr),
    //                       subtitle: Text(post['body'],textDirection: TextDirection.ltr),
    //                     );
    //                 }).toList()
    //                 );
    return ListView.builder(
      itemCount: _postList.length,
      itemBuilder: (BuildContext context,int i){
                             return ListTile(
                          title: Text( _postList[i]['title'],textDirection:TextDirection.ltr),
                          subtitle: Text(_postList[i]['body'],textDirection: TextDirection.ltr),
                        );
      }

    );
  }
}
