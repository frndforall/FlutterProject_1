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