

import 'package:flutter/material.dart';
import 'package:myhomeapp/src/auth/auth_bloc.dart';
import 'package:myhomeapp/src/blocs/bloc_provider.dart';
import 'package:myhomeapp/src/blocs/meetup_bloc.dart';
import 'package:myhomeapp/src/blocs/user_blocs/user_bloc.dart';
import 'package:myhomeapp/src/screens/login_screen.dart';
import 'package:myhomeapp/src/screens/meetup_home_screen.dart';
import 'package:myhomeapp/src/screens/register_screen.dart';
import 'package:myhomeapp/src/widgets/common_screens.dart';

import 'src/screens/meetup_detail_screen.dart';
import 'src/screens/posts_screen.dart';
import 'src/services/auth_service.dart';

void main() => runApp( App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(child: MyApp(),
    bloc: AuthBloc(provider: AuthProvider()));

    
  }
}


class MyApp extends StatefulWidget {
 
  createState() => _MyApp();
}



class _MyApp extends State<MyApp> {
final String title ='Sodhan App';
AuthBloc authBloc;
  
  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    authBloc.dispatch(AppStarted());
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(

        primarySwatch: Colors.red,
    ),
    home: StreamBuilder<AuthenticationState> (
      initialData: AuthenticationUninitialized(),
      stream: authBloc.stateStream,
      builder: (BuildContext context,AsyncSnapshot<AuthenticationState> snapshot) {
        final state = snapshot.data;

          if (state is AuthenticationUninitialized) {
            return SplashScreen();
          }

          if (state is AuthenticationAuthenticated) {
            return BlocProvider<MeetupBloc>(
              bloc: MeetupBloc(),
              child: MeetUpHomeScreen()
            );
          }

          if (state is AuthenticationUnauthenticated) {
            final LoginArguments arg = !state.logout?ModalRoute.of(context).settings.arguments:null;
            return LoginScreen(arg?.message);
          }

          if (state is AuthenticationLoading) {
            return LoadingScreen();
          }
          // return LoginScreen('');
      }
      
    ),
    
    routes: {
      RegisterScreen.route: (context) => RegisterScreen()
    },

    onGenerateRoute:(RouteSettings settings) {
      
      if(settings.name == MeetupDetails.route) {
        final MeetupArguments arg = settings.arguments;
        return MaterialPageRoute(builder: (context) => BlocProvider<MeetupBloc>(
            bloc: MeetupBloc(),
            child: BlocProvider<UserBloc> (
              bloc: UserBloc(auth: AuthProvider()),
              child: MeetupDetails(data: arg?.id)
            ),
        ));
      } else if(settings.name == MeetUpHomeScreen.route) {
       return MaterialPageRoute(builder: (context) => BlocProvider<MeetupBloc>(
            bloc: MeetupBloc(),
            child: MeetUpHomeScreen(),
        ));
       
      } else if(settings.name == LoginScreen.route) {
        final LoginArguments arg = settings.arguments;
        return MaterialPageRoute(builder: (context) => LoginScreen(arg?.message));
      } else {
        return MaterialPageRoute(builder: (context) => PostScreen());
      }

    },
    );
  }
  }



class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have clicked on the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.body1,
            ),
            Text('Checking the text direction',textDirection: TextDirection.rtl),
            RaisedButton(onPressed: _incrementCounter, key: Key('Value'))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),  // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


//Text('Welcome to Business App',textDirection: TextDirection.ltr)