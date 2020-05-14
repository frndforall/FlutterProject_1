
import 'package:myhomeapp/src/blocs/bloc_provider.dart';
import 'package:myhomeapp/src/blocs/user_blocs/user_events.dart';
import 'package:myhomeapp/src/blocs/user_blocs/user_states.dart';
import 'package:myhomeapp/src/model/meetup.dart';
import 'package:myhomeapp/src/model/user.dart';
import 'package:myhomeapp/src/services/auth_service.dart';
import 'package:rxdart/rxdart.dart';

export 'package:myhomeapp/src/blocs/user_blocs/user_events.dart';
export 'package:myhomeapp/src/blocs/user_blocs/user_states.dart';

class UserBloc extends BlocBase {

  AuthProvider auth;

  UserBloc({this.auth}) : assert(auth!=null);

  final BehaviorSubject<UserState> stateController = BehaviorSubject<UserState>();

  Stream<UserState> get stateStream => stateController.stream;
  Sink<UserState> get _stateSink => stateController.sink;

  dispatch(UserEvent event) async {
     await for (var state in _userStream(event)) {
      _stateSink.add(state);
      print(state);
    }
  }
   Stream<UserState> _userStream(UserEvent event) async* {

    if (event is CheckUserPermissionsOnMeetup) {
      // change it for auctual auth
      final bool isAuth = await auth.isAuthenticated();
      if (isAuth) {
        // Get here actual user
        final User user = auth.authUser;
        final meetup = event.meetup;

        if (_isUserMeetupOwner(user,meetup)) {
          yield UserIsMeetupOwner();
          return;
        }

        if (_isUserJoinedInMeetup(user,meetup)) {
          yield UserIsMember();
        } else {
          yield UserIsNotMember();
        }

      } else {
        yield UserIsNotAuth();
      }
    }

    if(event is JoinMeetupEvent) {
      yield UserIsMember();
    }

    if(event is LeaveMeetupEvent) {
      yield UserIsNotMember();
    }
  }

  bool _isUserMeetupOwner(User user, Meetup meetup) {
    return (user!=null && user.id == meetup.meetupCreator.id);
  }

  bool _isUserJoinedInMeetup(User user, Meetup meetup) {
    return (user!=null && user.joinedMeetups.isNotEmpty && user.joinedMeetups.contains(meetup.id));
  }


  dispose() {
    stateController.close();
  }
}