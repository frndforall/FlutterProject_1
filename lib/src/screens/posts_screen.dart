import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myhomeapp/model/post.dart';
// import 'dart:convert';

class PostScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    
    return _PostScreenState();
  }

}

class _PostScreenState extends State<PostScreen>{
  List<Post> _postlist = [];

  @override
  void initState() { 
    super.initState();
    getPosts();
  }

  void getPosts() {
   http.get('https://jsonplaceholder.typicode.com/posts')
    .then((res){
      // print(res.body);
      final List<dynamic> parsedValues = json.decode(res.body);
      final posts = parsedValues.map((parsedValues){
          return Post.fromJson(parsedValues);
      }).toList();
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

List<Post> _postList;

_PostList(List<Post> list) {
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
      itemCount: _postList.length * 2,
      itemBuilder: (BuildContext context,int i){
        final index  = i~/2;
        if( i.isOdd) {
          return Divider();
        } else {
                             return ListTile(
                          title: Text( _postList[index].title,textDirection:TextDirection.ltr),
                          subtitle: Text( _postList[index].body,textDirection: TextDirection.ltr),
                        );
         }
      }

    );
  }
}
