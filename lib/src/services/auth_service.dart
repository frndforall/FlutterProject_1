import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:myhomeapp/src/model/login_form_data.dart';
import 'package:myhomeapp/src/model/user.dart';
import 'package:myhomeapp/utils/jwt_utils.dart';
import 'dart:io' show Platform;
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<Map<String,dynamic>> get decodedToken async {
     final token = await this.token;
    if (token!=null  && token.isNotEmpty) {
      return decode(token);
    }
     return null;
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
    final decodeToken = await decodedToken;
    if(decodeToken !=null )
      return (decodeToken['exp']*1000 > DateTime.now().millisecond);

    return false;
   }

   void initUserFromToken() async{
     authUser = await decodedToken;
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

   Future<bool> register(RegisterFormData data) async {
     print(data.toJSON());
    final body = json.encode(data.toJSON());
    final res = await http.post('$baseUrl/users/register', 
    headers: {"Content-type":"application/json"},
    body: body);
    final parsedData = Map<String,dynamic>.from(json.decode(res.body));
    if(res.statusCode == 200) {
      return true;
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

   Future<User> fetchIUserDetails() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      final res = await http.get('$baseUrl/users/me',
                      headers: {'Authorization': 'Bearer $token'});
      if(res.statusCode == 200){
        final decodedToken = Map<String,dynamic>.from(json.decode(res.body));
        await _saveToken(decodedToken['token']);
        authUser = decodedToken;
        return authUser;
      } else {

      }
    } catch(e) {
      await _removeUserDetails();
      throw Exception('Cannot fetch user');
    }
  }


}