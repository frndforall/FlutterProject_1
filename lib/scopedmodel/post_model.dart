

import 'package:faker/faker.dart';
import 'package:myhomeapp/src/model/post.dart';

import 'package:myhomeapp/src/services/post_api_service.dart';
import 'package:scoped_model/scoped_model.dart';

class PostModel extends Model {

  List<Post> posts = [];
  final testingState  ='testing state';

  PostApiProvider provider = PostApiProvider.internal();
  PostModel() {
    getPosts();
  }

   void getPosts() async {
   posts = await provider.getPosts();

    notifyListeners();
  }


   addPost() {
    final id=faker.randomGenerator.integer(99999);
    final title = faker.food.dish();
    final body = faker.food.cuisine();
    final post = Post(title, body, id);
    posts.add(post);

    notifyListeners();
  }

}