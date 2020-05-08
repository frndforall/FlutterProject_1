

import 'package:faker/faker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:myhomeapp/model/post.dart';
import 'package:myhomeapp/services/post_api_service.dart';
import 'package:myhomeapp/state/app_state.dart';

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

  _addPost() {
    final id=faker.randomGenerator.integer(99999);
    final title = faker.food.dish();
    final body = faker.food.cuisine();
    final post = Post(title, body, id);
    setState(() {
      _postlist.add(post);
    });
  }
  @override
  Widget build(BuildContext context) {
    return _InherittedPost(_PostList(),_postlist,_addPost);
  }

}



class _PostList extends StatelessWidget {



@override
  Widget build(BuildContext context) {
    final post = _InherittedPost.of(context).postList;
    final appData = AppStore.of(context).testData1;


    return Scaffold(body:ListView.builder(
      itemCount: post.length * 2,
      itemBuilder: (BuildContext context,int i){
        final index  = i~/2;
        if( i.isOdd) {
          return Divider();
        } else {
              return ListTile(
                      title: Text( post[index].title,textDirection:TextDirection.ltr),
                      subtitle: Text( post[index].body,textDirection: TextDirection.ltr),
                      );
         }
      }

    ),
                  appBar: AppBar(title: Text(appData),),
                  floatingActionButton: _PostButton(),
                  );
    
  }

 
}
 class _PostButton extends StatelessWidget {
    Widget build(BuildContext context) {
     return FloatingActionButton(onPressed: (){
                  _InherittedPost.of(context).createPost();
                 }
                  ,tooltip: 'Add Post Lists');
    }
}

class _InherittedPost extends InheritedWidget {

  final List<Post> postList;
  final Function createPost;

  final Widget child;

  _InherittedPost(this.child,this.postList,this.createPost): super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static _InherittedPost of(BuildContext context){
      return (context.dependOnInheritedWidgetOfExactType<_InherittedPost>());
  }
  
}
