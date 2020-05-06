class Post {
 final String title;
final String body;

Post.fromJson(Map<String,dynamic> parsedJson):
  this.title = parsedJson['title'],
  this.body = parsedJson['body'];

}