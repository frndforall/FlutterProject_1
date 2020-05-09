

import 'package:flutter/material.dart';

class MeetUpHomeScreen extends StatefulWidget {
  @override
  MeetupHome createState() {

    return MeetupHome();
  }
  
}

class MeetupHome extends State<MeetUpHomeScreen>{
  
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
  Widget build(BuildContext context) {
    return Card(child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(leading: CircleAvatar(backgroundImage: NetworkImage('https://images.unsplash.com/photo-1519999482648-25049ddd37b1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2452&q=80')),
                  title: Text('title of the card',),
                  subtitle: Text('subtitle of the card'),),
                    ButtonBar(children: <Widget>[
                    FlatButton(child: Text('Visit Meetup'), onPressed: () {},),
                    FlatButton(child: Text('Favorite'), onPressed: () {},),

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
  List<_MeetupCard> _meetupList= [_MeetupCard(),_MeetupCard(),_MeetupCard()];
  Widget build(BuildContext context) {
    return Expanded(child:  ListView.builder(
      itemCount: _meetupList.length*2,
      itemBuilder: (BuildContext context,int i){
        final index  = i~/2;
            if( i.isOdd) {
              return Divider();
               } else {
              return _meetupList[index];
                }
              }

          )
    );
  }
}
