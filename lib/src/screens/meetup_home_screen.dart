

import 'package:flutter/material.dart';
import 'package:myhomeapp/src/blocs/bloc_provider.dart';
import 'package:myhomeapp/src/blocs/meetup_bloc.dart';
import 'package:myhomeapp/src/model/meetup.dart';
import 'package:myhomeapp/src/screens/login_screen.dart';
import 'package:myhomeapp/src/screens/meetup_detail_screen.dart';
import 'package:myhomeapp/src/services/auth_service.dart';
import 'package:myhomeapp/src/services/meetup_api_service.dart';

class MeetupArguments {
  final String id;
  MeetupArguments({this.id});
}

class MeetUpHomeScreen extends StatefulWidget {

  static final String route = '/meetupHome';

  @override
  MeetupHome createState() {
    return MeetupHome();
  }
  
}

class MeetupHome extends State<MeetUpHomeScreen>{
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<MeetupBloc>(context).fetchMeetups();
    // final meetups =BlocProvider.of<MeetupBloc>(context);
    // meetups.fetchMeetups();
    // meetups.meetups.listen((data) {
    //       print(data);
    // });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Column(children: <Widget>[
    Meetuptitle(),
    MeetupCardList()
        ]),

      ),
    appBar: AppBar(title: Text('Meetup Home')));
  }

}

class _MeetupCard extends StatelessWidget {
  final Meetup details;

  _MeetupCard(this.details);

  Widget build(BuildContext context) {
    return Card(child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(leading: CircleAvatar(radius: 25.0,
                  backgroundImage: NetworkImage(details.image)),
                  title: Text(details.title),
                  subtitle: Text(details.description),),
                    ButtonBar(children: <Widget>[
                    FlatButton(child: Text('Visit Meetup'), onPressed: () {
                      Navigator.pushNamed(context, MeetupDetails.route, arguments: MeetupArguments(id: details.id));
                    },),
                    FlatButton(child: Text('Favorite'), onPressed: () {
                      Navigator.pushNamed(context, '/postDetails');

                    },),

                  ],)
      ],),);
  }
}

class Meetuptitle extends StatelessWidget {

   final AuthProvider auth = AuthProvider();

  Widget _buildUserWelcome()  {
    return FutureBuilder<bool>(
      future: auth.isAuthenticated(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData && snapshot.data) {
          final user = auth.authUser;
          return Container(
            margin: EdgeInsets.only(top: 10.0),
            child: Row(
              children: <Widget>[
                user.avatar != null
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(user.avatar),
                    )
                  : Container(width: 0, height: 0),
                Text('Welcome ${user.username}'), Spacer(),
                Padding(padding: EdgeInsets.only(left: 20.0),   
                  child: GestureDetector(child: Text('Logout'),onTap: () {
                    auth.logoutUser().then((value) {
                        Navigator.pushNamedAndRemoveUntil(context, LoginScreen.route, (Route<dynamic> route) => false);
                    });
                   
                  
                },))
              ],
            )
          );
        } else {
          return Container(width: 0, height: 0);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(20.0),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Featured Meetups', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold)),
          _buildUserWelcome()
        ]
      ));
  }
}

class MeetupCardList extends StatelessWidget {

  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<List<Meetup>>(
        stream: BlocProvider.of<MeetupBloc>(context).meetups,
        initialData: [],
        builder: (BuildContext context, AsyncSnapshot<List<Meetup>> snapshot){
          final meetups = snapshot.data;
            return ListView.builder(
                itemCount: meetups.length*2,
                itemBuilder: (BuildContext context,int i){
                  final index  = i~/2;
                      if( i.isOdd) {
                        return Divider();
                        } else {
                        return _MeetupCard(meetups[index]);
                          }
                        }

                    );
        },
        
        
        )
      
    );
  }
}
