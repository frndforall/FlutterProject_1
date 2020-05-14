
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myhomeapp/src/model/login_form_data.dart';

import 'package:myhomeapp/src/screens/login_screen.dart';
import 'package:myhomeapp/src/screens/meetup_home_screen.dart';
import 'package:myhomeapp/src/services/auth_service.dart';
import 'package:myhomeapp/utils/constants.dart';
import 'package:myhomeapp/utils/validator.dart';

class RegisterScreen extends StatefulWidget {
  static final String route = '/register';

  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  // 1. Create GlobalKey for form
  // 2. Create autovalidate
  // 3. Create instance of RegisterFormData
  // 4. Create Register function and print all of the data
  final GlobalKey<FormState> _registerform = GlobalKey<FormState>();
  RegisterFormData formData = RegisterFormData();
  bool _autoValidator = false;
  BuildContext _scaffoldContext;

  AuthProvider provider = AuthProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text('Register')
      ),
      body: Builder(
        builder: (context) {
          _scaffoldContext= context;
          return Padding(
            padding: EdgeInsets.all(20.0),
            child: Form(
              autovalidate: _autoValidator,
              key: _registerform,
              child: ListView(
                children: [
                  _buildTitle(),
                  TextFormField(
                    style: Theme.of(context).textTheme.headline,
                    decoration: InputDecoration(
                      hintText: 'Name',
                    ),
                    validator:  (value) {
                    return composeValidators(value,
                                   'email',
                                   [requiredValidator]);
                  
                      },
                      onSaved: (value) {formData.name = value;},
                    
                    // 6. Required Validator
                    // 7. onSaved - save data to registerFormData
                  ),
                  TextFormField(
                    style: Theme.of(context).textTheme.headline,
                    decoration: InputDecoration(
                      hintText: Constants.username,
                    ),
                    validator: (value) {
                    return composeValidators(value,
                                   Constants.username,
                                   [requiredValidator]);
                  
                      },
                      onSaved: (value) {formData.username = value;},
                  ),
                  TextFormField(
                    style: Theme.of(context).textTheme.headline,
                    decoration: InputDecoration(
                      hintText: Constants.email,
                    ),
                    validator: (value) {
                      return composeValidators(value,
                                   Constants.email,
                                   [requiredValidator,minLengthValidator,emailValidator]);
                    },
                    onSaved: (value) {
                      formData.email = value;
                    },
                    keyboardType: TextInputType.emailAddress
                  ),
                  TextFormField(
                    style: Theme.of(context).textTheme.headline,
                    decoration: InputDecoration(
                      hintText: 'Avatar Url',
                    ),
                    validator: (value) {
                      return composeValidators(value,
                                   'user name',
                                   [requiredValidator]);
                    },
                    onSaved: (value) {
                      formData.avatar = value;
                    },
                    keyboardType: TextInputType.url
                  ),
                  TextFormField(
                    style: Theme.of(context).textTheme.headline,
                    decoration: InputDecoration(
                      hintText: 'Password',
                    ),
                    validator: (value) {
                       return composeValidators(value,
                                   'user name',
                                   [requiredValidator,minLengthValidator]);
                    },
                    onSaved: (value) {
                      formData.password = value;
                    },
                    obscureText: true,
                  ),
                  TextFormField(
                    style: Theme.of(context).textTheme.headline,
                    decoration: InputDecoration(
                      hintText: 'Password Confirmation',
                    ), validator: (value) {
                       return composeValidators(value,
                                   'user name',
                                   [requiredValidator,minLengthValidator]);
                    },
                    onSaved: (value) {
                      formData.passwordConfirmation = value;
                    },
                    obscureText: true,
                  ),
                  _buildLinksSection(),
                  _buildSubmitBtn()
                ],
              ),
            )
          );
        }
      )
    );
  }

  Widget _buildTitle() {
    return Container(
      margin: EdgeInsets.only(bottom: 15.0),
      child: Text(
        'Register Today',
        style: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  Widget _buildSubmitBtn() {
    return Container(
      alignment: Alignment(-1.0, 0.0),
      child: RaisedButton(
        textColor: Colors.white,
        color: Theme.of(context).primaryColor,
        child: const Text('Submit'),
        onPressed: () {
          _registerUser();
        },
      )
    );
  }

  _registerUser() {
    final form = _registerform.currentState;
    if(form.validate()) {
        form.save();
        provider.register(formData).then((value) {
          if(value) {
              print('Registered sucessful');
          } else {
            print('failed to register');
          }
          Navigator.pushNamedAndRemoveUntil(context, "/", (Route<dynamic> route) => false, arguments: LoginArguments(Constants.loginArguments));
        }).catchError((error) {
           print(error);
           Scaffold.of(_scaffoldContext).showSnackBar(SnackBar(
          content: Text(error['errors']['message'])
        ));
        });
        
    } else {
      setState((){
        _autoValidator = true;
      });
    }

  }

  Widget _buildLinksSection() {
    return Padding(
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, LoginScreen.route);
            },
            child: Text(
              'Already Registered? Login Now.',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, MeetUpHomeScreen.route);
            },
            child: Text(
              'Continue to Home Page',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            )
          )
        ],
      ),
    );
  }
}

