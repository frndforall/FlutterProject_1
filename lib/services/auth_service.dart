import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:myhomeapp/utils/jwt_utils.dart';
import 'dart:io' show Platform;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:myhomeapp/model/login_form_data.dart';
import 'package:myhomeapp/model/user.dart';

class AuthProvider {
  
  final String baseUrl = Platform.isAndroid?'http://10.0.2.2:3001/api/v1':'http://localhost:3001/api/v1';
  String _token;
  User _authUser;
  
  static final AuthProvider provider= AuthProvider.internal();

  factory AuthProvider() {
    return provider;
  }

  AuthProvider.internal();
 Future<String> get token async {
    if (_token!=null && _token.isNotEmpty) {
      return _token;
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString('token');
    }
  }

  Future<bool> _persistToken(token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('token', token);
  }

  Future<bool> _saveToken(String token) async {
    if (token != null) {
      _token = token;
      await _persistToken(token);
      return true;
    }

    return false;
  }

  set authUser(Map<String, dynamic> value) {
    _authUser = User.fromJSON(value);
  }

   Future<bool> isAuthenticated() async {
    final token = await this.token;
    if (token.isNotEmpty) {
      final decodeToken = decode(token);
      final expiry = decodeToken['exp'] * 1000;
      final isValidToken = (expiry>DateTime.now().millisecond);
      
      if(isValidToken) {
        authUser = decodeToken;
        print('token is validated with $expiry');
      }
      return isValidToken;
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

  Future<bool> logoutUser() async{
    try{
     await _removeUserDetails();
     return true;
    }catch(error) {
      print(error);
      return false;
    }

  }

  _removeUserDetails() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    _token = '';
    authUser=null;
  }


}