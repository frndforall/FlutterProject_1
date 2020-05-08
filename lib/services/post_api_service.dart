import 'package:http/http.dart' as http;
import 'package:myhomeapp/model/post.dart';
import 'dart:convert';

class PostApiProvider  {

  static final PostApiProvider provider= PostApiProvider.internal();

  PostApiProvider.internal();

  factory PostApiProvider() {
    return provider;
  }

  Future<List<Post>> getPosts() async{
  final res= await  http.get('https://jsonplaceholder.typicode.com/posts');
  
      // print(res.body);
      final List<dynamic> parsedValues = json.decode(res.body);
      return parsedValues.map((parsedValues){
          return Post.fromJson(parsedValues);
      }).take(3).toList();
     
  }

}
