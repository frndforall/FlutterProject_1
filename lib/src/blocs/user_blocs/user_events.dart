
import 'package:meta/meta.dart';
import 'package:myhomeapp/src/model/meetup.dart';

abstract class UserEvent {}

class CheckUserPermissionsOnMeetup extends UserEvent {
  Meetup meetup;

  CheckUserPermissionsOnMeetup({@required this.meetup});

  @override
  String toString() => 'CheckUserPermissionsOnMeetup';
}


class JoinMeetupEvent extends UserEvent {

  @override
  String toString() => 'JoinMeetupEvent';
}


class LeaveMeetupEvent extends UserEvent {
  @override
  String toString() => 'LeaveMeetupEvent';
}