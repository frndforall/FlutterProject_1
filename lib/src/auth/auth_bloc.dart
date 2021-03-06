
import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:myhomeapp/src/blocs/bloc_provider.dart';
import 'package:myhomeapp/src/services/auth_service.dart';

import 'auth_states.dart';
import 'events.dart';

export 'auth_states.dart';
export 'events.dart';


class AuthBloc extends BlocBase {
  final AuthProvider provider;

  final BehaviorSubject<AuthenticationState> stateController = BehaviorSubject<AuthenticationState>();

  Stream<AuthenticationState> get stateStream => stateController.stream;
  Sink<AuthenticationState> get _stateSink => stateController.sink;

  AuthBloc({this.provider}) : assert(provider!=null);
  void dispatch(AuthenticationEvent event) async {
    await for (var state in _authStream(event)) {
      _stateSink.add(state);
      print(state);
    }
  }


  Stream<AuthenticationState> _authStream(AuthenticationEvent event) async* {
    if (event is AppStarted) {
        // Check if user is authenticated
        final bool isAuth = await provider.isAuthenticated();
        if (isAuth) {
          print(event);
          // provider.initUserFromToken();
          await provider.fetchIUserDetails().catchError((onError) {
              dispatch(LoggedOut(message:'Invalid User. Please Login again.'));
          });

          yield AuthenticationAuthenticated();
        } else {
          yield AuthenticationUnauthenticated();
        }
    }
      if (event is InitLogging) {
        yield AuthenticationLoading();
      }

      if (event is LoggedIn) {
        yield AuthenticationAuthenticated();
      }

      if (event is LoggedOut) {
        yield AuthenticationUnauthenticated(logout: true, message: event.message);
      }
  
  }

  dispose() {
      stateController.close();
  }
}

