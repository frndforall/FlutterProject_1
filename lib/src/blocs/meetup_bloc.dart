import 'dart:async';

import 'package:myhomeapp/src/model/meetup.dart';
import 'package:myhomeapp/src/model/user.dart';
import 'package:myhomeapp/src/services/auth_service.dart';
import 'package:myhomeapp/src/services/meetup_api_service.dart';

import 'bloc_provider.dart';



class MeetupBloc implements BlocBase {
  final MeetupApiProvider _api = MeetupApiProvider();
  AuthProvider provider= AuthProvider();

  final StreamController<List<Meetup>> _meetupController = StreamController.broadcast();
  Stream<List<Meetup>> get meetups => _meetupController.stream;
  StreamSink<List<Meetup>> get _inMeetups => _meetupController.sink;


  final StreamController<Meetup> _meetupDetailsController = StreamController.broadcast();
  Stream<Meetup> get meetup => _meetupDetailsController.stream;
  StreamSink<Meetup> get meetupDetails => _meetupDetailsController.sink;

  void fetchMeetups() async {
    final meetups = await _api.getMeetups();
    _inMeetups.add(meetups);
  }

   void fetchMeetupDetails(String id) async {
    final meetup = await _api.getSelectedMeetup(id);
    meetupDetails.add(meetup);
  }

  void joinMeetup(Meetup meetup) async {
     _api.joinMeetup(meetup.id).then((_){
        User user = provider.authUser;
        user.joinedMeetups.add(meetup.id);
        meetup.joinedPeople.add(user);
        meetup.joinedPeopleCount++;
        meetupDetails.add(meetup);
     });
    
  }

  void leaveMeetup(Meetup meetup) async {
      _api.leaveMeetup(meetup.id).then((_){
        User user = provider.authUser;
        user.joinedMeetups.removeWhere((newId)=> newId == meetup.id);
        meetup.joinedPeople.removeWhere((jUser) => jUser.id == user.id );
        meetup.joinedPeopleCount--;
        meetupDetails.add(meetup);
     });
  }



  void dispose() {
    _meetupController.close();
    _meetupDetailsController.close();
  }
}