
import 'dart:async';

import 'package:myhomeapp/src/blocs/bloc_provider.dart';
import 'package:myhomeapp/src/services/auth_service.dart';

import 'auth_states.dart';
import 'events.dart';

export 'auth_states.dart';
export 'events.dart';


class AuthBloc extends BlocBase {
  final AuthProvider provider;

  final StreamController<AuthenticationState> stateController = StreamController<AuthenticationState>();

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
        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationUnauthenticated();
      }

      if (event is InitLogging) {
        yield AuthenticationLoading();
      }

      if (event is LoggedIn) {
        yield AuthenticationAuthenticated();
      }

      if (event is LoggedOut) {
        yield AuthenticationUnauthenticated();
      }
    }
  }

  dispose() {
      stateController.close();
  }
}

