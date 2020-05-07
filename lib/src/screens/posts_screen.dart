

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:myhomeapp/model/post.dart';
import 'package:myhomeapp/services/post_api_service.dart';
// import 'dart:convert';

class PostScreen extends StatefulWidget {
  PostApiProvider apiProvider = PostApiProvider();
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

  void getPosts() async {
   List<Post> posts = await widget.apiProvider.getPosts();
      setState(() {
        _postlist = posts;
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
