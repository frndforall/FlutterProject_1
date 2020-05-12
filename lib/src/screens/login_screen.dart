
import 'package:flutter/material.dart';

import 'package:myhomeapp/src/model/login_form_data.dart';
import 'package:myhomeapp/src/screens/meetup_home_screen.dart';
import 'package:myhomeapp/src/screens/register_screen.dart';
import 'package:myhomeapp/src/services/auth_service.dart';

import 'package:myhomeapp/utils/validator.dart';

// import 'register_screen.dart';

class LoginArguments{
  String message = '';
  LoginArguments(this.message);
}

class LoginScreen extends StatefulWidget {
  static final String route='/loginscreen';
  final String message;
  final AuthProvider api = AuthProvider();
  
  LoginScreen(this.message);
  LoginScreenState createState() => LoginScreenState();

}

class LoginScreenState extends State<LoginScreen> {

  BuildContext _scaffoldContext;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> _passwordKey = GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _emailKey = GlobalKey<FormFieldState<String>>();
  LoginFormData formData = LoginFormData();

  bool _autovalidate = false;
  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkMessage());
  }

  void _checkMessage() {
    if(widget.message!=null && widget.message.isNotEmpty) {
      Scaffold.of(_scaffoldContext).showSnackBar(SnackBar(content : Text(widget.message)));
    }
  }

  Widget build(BuildContext context) {
   
      return Scaffold(body: Builder(builder: (context) {
        _scaffoldContext = context;
      
        return Padding(
        
        padding: EdgeInsets.all(10.0),
        child: Form(
          autovalidate:_autovalidate,
          key: _formKey,
          // Provide key
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 15.0),
                child: Text(
                  'Login And Explore',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              TextFormField(
                key: _emailKey,
                onSaved: (value){formData.email = value;},
                 validator: (value) {
                    return composeValidators(value,
                                   'email',
                                   [requiredValidator, minLengthValidator, emailValidator]);
                  
                },
                style: Theme.of(context).textTheme.subhead,
                decoration: InputDecoration(
                  hintText: 'Email Address'
                ),
              ),
              TextFormField(
                key: _passwordKey,
                obscureText: true,
                onSaved: (value){formData.pass = value;},
                validator: (value) {
                    return composeValidators(value,
                                   'password',
                                   [requiredValidator, minLengthValidator]);
                },
                style: Theme.of(context).textTheme.subhead,
                decoration: InputDecoration(
                  hintText: 'Password'
                ),
              ),
              _buildLinks(),
              Container(
                alignment: Alignment(-1.0, 0.0),
                margin: EdgeInsets.only(top: 10.0),
                child: RaisedButton(
                  textColor: Colors.white,
                  color: Theme.of(context).primaryColor,
                  child: const Text('Submit'),
                  onPressed: _submit
                )
              )
            ],
          ),
        ));
        }
      ),
      appBar: AppBar(title: Text('Login')),
      );
  }

  void _login() {
     widget.api
        .login(formData)
        .then((data) {
            Navigator.pushNamed(context, MeetUpHomeScreen.route);
        })
        .catchError((res) {
        Scaffold.of(_scaffoldContext).showSnackBar(SnackBar(
          content: Text(res['errors']['message'])
        ));
      });
  }

  _submit() {
    final form = _formKey.currentState;
    if(form.validate()) {
        // final email = _emailKey.currentState.value;
        // final pass = _passwordKey.currentState.value;
        form.save();
        _login();  
        
    } else {
      setState((){
        _autovalidate = true;
      });
    }
  }

  Widget _buildLinks() {
    return Padding(
      padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, RegisterScreen.route),
            child: Text(
              'Not Registered yet? Register Now!',
              style: TextStyle(
                color: Theme.of(context).primaryColor
              )
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, MeetUpHomeScreen.route),
            child: Text(
              'Continue to Home Page',
              style: TextStyle(
                color: Theme.of(context).primaryColor
              )
            ),
          )
        ],
      )
    );
  }
}
