


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// import 'package:myhomeapp/model/post.dart';
import 'package:myhomeapp/scopedmodel/post_model.dart';
import 'package:myhomeapp/widgets/bottom_navigation_design.dart';

import 'package:scoped_model/scoped_model.dart';

// import 'dart:convert';

class PostScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    
    return _PostScreenState();
  }

}

class _PostScreenState extends State<PostScreen>{


  @override
  void initState() { 
    super.initState();
  }

 
  @override
  Widget build(BuildContext context) {

    return ScopedModel<PostModel>(child: _PostList(), model: PostModel(),
        

    );
    // return _InherittedPost(_PostList(),_postlist,_addPost);
  }

}



class _PostList extends StatelessWidget {

@override
  Widget build(BuildContext context) {
    // final post = _InherittedPost.of(context).postList;
    // final appData = AppStore.of(context).testData1;


    return ScopedModelDescendant<PostModel>(builder: (context, __, model) {
      final post = model.posts;
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
                  appBar: AppBar(title: Text(model.testingState),),
                  floatingActionButton: _PostButton(),
                  bottomNavigationBar: BottomNavigation(),
                  );
    }
    );
                
}
}

 class _PostButton extends StatelessWidget {
    Widget build(BuildContext context) {
      final postModel = ScopedModel.of<PostModel>(context,rebuildOnChange: true);
     return FloatingActionButton(onPressed: (){
                    postModel.addPost();
                 }
                  ,tooltip: 'Add Post Lists');
    }
}

// class _InherittedPost extends InheritedWidget {

//   final List<Post> postList;
//   final Function createPost;

//   final Widget child;

//   _InherittedPost(this.child,this.postList,this.createPost): super(child: child);

//   @override
//   bool updateShouldNotify(InheritedWidget oldWidget) {
//     return true;
//   }

//   // Static referencing for a class.
//   static _InherittedPost of(BuildContext context){
//       return (context.dependOnInheritedWidgetOfExactType<_InherittedPost>());
//   }
  
// }
