
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myhomeapp/model/meetup.dart';
import 'package:myhomeapp/services/meetup_api_service.dart';

import 'package:myhomeapp/widgets/bottom_navigation_design.dart';


class MeetupDetails extends StatefulWidget {
  static final String route = '/meetupDetail';
  final String data;

  final MeetupApiProvider api =MeetupApiProvider.internal();


  MeetupDetails({this.data});

  @override
  MeetupDetailScreen createState() {
    return MeetupDetailScreen();
  }
  
}

class MeetupDetailScreen extends State<MeetupDetails>{
  Meetup meetup;
  
@override
  void initState() {  
    super.initState();
    fetchMeetupDetails();
  }

  void fetchMeetupDetails() async{
    Meetup meetupdetails = await widget.api.getSelectedMeetup(widget.data);
    setState(() {
      this.meetup = meetupdetails;
    });
  }
  
  buildBody() {
    if(meetup != null) {
      return Center(child: Column(children: <Widget>[
                  MeetupHeaderSection(meetup: meetup),
                  MeetupTitleSection(meetup: meetup),
                  InfoSection(meetup: meetup),
                  Padding(padding: EdgeInsets.all(20.0), child: Text(meetup.description,style: TextStyle(fontSize: 20.0),),)]),);

    } else {
      return Container(width: 0.0,height: 0.0);
    }
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:buildBody(),
      appBar:AppBar(title:Text('Meetup Details')),
      bottomNavigationBar: BottomNavigation(),
    );
  }

}

class MeetupHeaderSection extends StatelessWidget {
  final Meetup meetup;
  

  MeetupHeaderSection({this.meetup});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: <Widget>[
      Image.network(meetup.image, width: screenWidth,height:200.0,fit: BoxFit.cover),
      Container(decoration: BoxDecoration(color: Colors.black.withOpacity(0.3)), child: Padding(padding: EdgeInsets.only(top: 10.0,bottom: 10.0)   ,child: ListTile(leading: CircleAvatar(radius: 20.0,backgroundImage: NetworkImage('https://www.pngkey.com/png/full/950-9501315_katie-notopoulos-katienotopoulos-i-write-about-tech-user.png'),),
      title: Text(meetup.title,style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold)),
      subtitle: Text(meetup.shortInfo,style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold)),
    )))],);
  }
}

class MeetupTitleSection extends StatelessWidget {
  final Meetup meetup;

  MeetupTitleSection({this.meetup});

  Widget build(BuildContext context) {
      return Padding(padding: EdgeInsets.all(10.0),
      child:Row ( children: <Widget>[Expanded(child: Padding(padding: EdgeInsets.all(10.0),  child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: <Widget>[
          Text(meetup.title,style: TextStyle(color: Colors.black,fontSize: 14.0,fontWeight: FontWeight.bold)),
          Text(meetup.shortInfo,style: TextStyle(color: Colors.black,fontSize: 14.0,fontWeight: FontWeight.normal))
        ],),)),
        Padding(padding: EdgeInsets.all(20.0), child: Row(children: <Widget>[Icon(Icons.people,color: Colors.blue), Text('${meetup.joinedPeopleCount} people')],)
        )]));
  }
}

class InfoSection extends StatelessWidget {
  final Meetup meetup;
  InfoSection({this.meetup});

  buildColumn(String label,String value) {
    return Column(children: <Widget>[
                            Text(label,style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 15.0)),
                            Text(value, style :TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20.0))
                          ],);
  }

  Widget build(BuildContext context) {
      return Padding(padding: EdgeInsets.all(20.0), 
                      child: Row(children: <Widget>[Expanded(child: buildColumn('Category', meetup.category.name)),
                         Expanded(child:buildColumn('From', meetup.timeFrom)),
                          Expanded(child:buildColumn('To', meetup.timeTo))
                      ]));
  }

}