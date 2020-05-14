import 'package:http/http.dart' as http;
import 'dart:io' show Platform;
import 'dart:convert';

import 'package:myhomeapp/src/model/meetup.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MeetupApiProvider  {

  static final MeetupApiProvider provider= MeetupApiProvider.internal();
  final String baseUrl = Platform.isAndroid?'http://10.0.2.2:3001/api/v1':'http://localhost:3001/api/v1';

  MeetupApiProvider.internal();

  factory MeetupApiProvider() {
    return provider;
  }

  Future<List<Meetup>> getMeetups() async{
  
  
  final res= await  http.get('$baseUrl/meetups');
  
      // print(res.body);
      final List<dynamic> parsedValues = json.decode(res.body);
      return parsedValues.map((parsedValues){
          return Meetup.fromJSON(parsedValues);
      }).toList();
     
  }

  Future<Meetup> getSelectedMeetup(String id) async {
      final res= await  http.get('$baseUrl/meetups/$id');
      final  parserValue = json.decode(res.body);
      return Meetup.fromJSON(parserValue);
  }


  Future<bool> joinMeetup(String meetupId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      await http.post('$baseUrl/meetups/$meetupId/join',
                      headers: {'Authorization': 'Bearer $token'});
      return true;
    } catch(e) {
      throw Exception('Cannot join meetup!');
    }
  }

  Future<bool> leaveMeetup(String meetupId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      await http.post('$baseUrl/meetups/$meetupId/leave',
                      headers: {'Authorization': 'Bearer $token'});
      return true;
    } catch(e) {
      throw Exception('Cannot leave meetup!');
    }
  }

}
