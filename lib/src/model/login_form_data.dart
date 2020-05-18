import 'package:myhomeapp/src/model/category.dart';

class LoginFormData {
  String email ="";
  String pass = "";

  Map<String,dynamic> toJson() => {
    'email' : email,
    'password' : pass
  };
}

class RegisterFormData {
  String email = '';
  String username = '';
  String name = '';
  String password = '';
  String passwordConfirmation = '';
  String avatar = '';

  Map<String, dynamic> toJSON() =>
    {
      'email': email,
      'username': username,
      'name': name,
      'password': password,
      'passwordConfirmation': passwordConfirmation,
      'avatar': avatar
    };
}

class MeetupFormData {
  String location = '';
  String title = '';
  DateTime startDate = DateTime.now();
  Category category;
  String image = '';
  String shortInfo = '';
  String description = '';
  String timeTo = '';
  String timeFrom = '';

  Map<String, dynamic> toJSON() =>
    {
      'location': location,
      'title': title,
      'startDate': startDate,
      'category': category,
      'image': image,
      'shortInfo': shortInfo,
      'description': description,
      'timeTo': timeTo,
      'timeFrom': timeFrom
    };
}