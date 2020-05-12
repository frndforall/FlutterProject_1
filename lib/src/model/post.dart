class Post {
  final String title;
  final String body;
  final int id;

  Post( this.title,this.body, this.id);

Post.fromJson(Map<String,dynamic> parsedJson):
  this.title = parsedJson['title'],
  this.body = parsedJson['body'],
  this.id = parsedJson['id'];

}