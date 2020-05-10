import 'package:http/http.dart' as http;
import 'dart:io' show Platform;
import 'dart:convert';

import 'package:myhomeapp/model/meetup.dart';

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

}
