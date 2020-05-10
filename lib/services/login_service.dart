import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:io' show Platform;

import 'package:myhomeapp/model/login_form_data.dart';
import 'package:myhomeapp/model/user.dart';

class LoginProvider {
  
  final String baseUrl = Platform.isAndroid?'http://10.0.2.2:3001/api/v1':'http://localhost:3001/api/v1';
  String _token;
  User _authUser;
  
  static final LoginProvider provider= LoginProvider.internal();

  factory LoginProvider() {
    return provider;
  }

  LoginProvider.internal();

   bool _saveToken(String token) {
    if (token != null) {
      _token = token;
      return true;
    }

    return false;
  }

  set authUser(Map<String, dynamic> value) {
    _authUser = User.fromJSON(value);
  }

    bool isAuthenticated() {
    if (_token.isNotEmpty) {
      return true;
    }

    return false;
  }

  get authUser => _authUser;

   Future<Map<String, dynamic>> login(LoginFormData loginData) async {
    final body = json.encode(loginData.toJson());
    
    final res = await http.post('$baseUrl/users/login', 
    headers: {"Content-type":"application/json"},
    body: body);

    final parsedData = Map<String,dynamic>.from(json.decode(res.body));
    if(res.statusCode == 200) {
      _saveToken(parsedData['token']);
      authUser = parsedData;
      return parsedData;
    } else {
      return Future.error(parsedData);
    }
  }



}