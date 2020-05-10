

import 'package:flutter/material.dart';

import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  static final String route='/registerScreen';

  RegisterScrenState createState() => RegisterScrenState();

}

class RegisterScrenState extends State<RegisterScreen> {
  Widget build(BuildContext context) {
      return Scaffold(body: Center(child: FlatButton(child: Text('Register'),onPressed: () {
          Navigator.pushNamed(context, LoginScreen.route);
      },)),
      appBar: AppBar(title: Text('Register')),
      );
  }
}
