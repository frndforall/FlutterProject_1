import 'dart:async';

import 'package:myhomeapp/src/model/meetup.dart';
import 'package:myhomeapp/src/services/meetup_api_service.dart';

import 'bloc_provider.dart';



class MeetupBloc implements BlocBase {
  final MeetupApiProvider _api = MeetupApiProvider();

  final StreamController<List<Meetup>> _meetupController = StreamController.broadcast();
  Stream<List<Meetup>> get meetups => _meetupController.stream;
  StreamSink<List<Meetup>> get _inMeetups => _meetupController.sink;

  void fetchMeetups() async {
    final meetups = await _api.getMeetups();
    _inMeetups.add(meetups);
  }

  void dispose() {
    _meetupController.close();
  }
}