

import 'package:flutter/material.dart';
import 'package:myhomeapp/model/meetup.dart';
import 'package:myhomeapp/services/meetup_api_service.dart';
import 'package:myhomeapp/src/screens/meetup_detail_screen.dart';

class MeetupArguments {
  final String id;
  MeetupArguments({this.id});
}

class MeetUpHomeScreen extends StatefulWidget {
  
  MeetupApiProvider _api = MeetupApiProvider.internal();

  @override
  MeetupHome createState() {
    return MeetupHome();
  }
  
}

class MeetupHome extends State<MeetUpHomeScreen>{
  List<Meetup> meetups = [];
  @override
  void initState() {
    super.initState();
    _fetchPost();
  }

  _fetchPost() async {
    meetups =await widget._api.getMeetups();
    setState(() {
      this.meetups = meetups;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Column(children: <Widget>[
    Meetuptitle(),
    MeetupCardList(meetups)
        ]),

      ),
    appBar: AppBar(title: Text('Meetup Home')));
  }

}

class _MeetupCard extends StatelessWidget {
  Meetup details;

  _MeetupCard(this.details);

  Widget build(BuildContext context) {
    return Card(child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(leading: CircleAvatar(backgroundImage: NetworkImage(details.image)),
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
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(20.0),
      child: Text('Featured Meetup',style: TextStyle(fontSize: 23.0,fontWeight: FontWeight.bold)));
  }
}

class MeetupCardList extends StatelessWidget {
  List<Meetup> meetups = [];
  MeetupCardList(this.meetups);
  // List<_MeetupCard> _meetupList= [_MeetupCard(),_MeetupCard(),_MeetupCard()];
  Widget build(BuildContext context) {
    return Expanded(child:  ListView.builder(
      itemCount: meetups.length*2,
      itemBuilder: (BuildContext context,int i){
        final index  = i~/2;
            if( i.isOdd) {
              return Divider();
               } else {
              return _MeetupCard(meetups[index]);
                }
              }

          )
    );
  }
}
