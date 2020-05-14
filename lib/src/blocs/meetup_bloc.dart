import 'dart:async';

import 'package:myhomeapp/src/model/meetup.dart';
import 'package:myhomeapp/src/services/meetup_api_service.dart';

import 'bloc_provider.dart';



class MeetupBloc implements BlocBase {
  final MeetupApiProvider _api = MeetupApiProvider();

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



  void dispose() {
    _meetupController.close();
    _meetupDetailsController.close();
  }
}