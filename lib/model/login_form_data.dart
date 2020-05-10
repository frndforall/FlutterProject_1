class LoginFormData {
  String email ="";
  String pass = "";

  Map<String,dynamic> toJson() => {
    'email' : email,
    'password' : pass
  };
}