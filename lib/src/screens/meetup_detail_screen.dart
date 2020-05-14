
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myhomeapp/src/blocs/bloc_provider.dart';
import 'package:myhomeapp/src/blocs/meetup_bloc.dart';
import 'package:myhomeapp/src/model/meetup.dart';
import 'package:myhomeapp/src/services/auth_service.dart';
import 'package:myhomeapp/src/widgets/bottom_navigation_design.dart';



class MeetupDetails extends StatefulWidget {
  static final String route = '/meetupDetail';
  final String data;
  MeetupDetails({this.data});
  @override
  MeetupDetailScreen createState() {
    return MeetupDetailScreen();
  }
}

class MeetupDetailScreen extends State<MeetupDetails>{

  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<MeetupBloc>(context).fetchMeetupDetails(widget.data); 
  }

  buildBody() {
    return StreamBuilder<Meetup>(stream: BlocProvider.of<MeetupBloc>(context).meetup ,
                                  initialData: null,
                                  builder: (BuildContext context, AsyncSnapshot<Meetup> snapshot){
                                    final meetup = snapshot.data;
                                     if(meetup != null) {
                                       print(meetup.category);
                                          return Center(child: Column(children: <Widget>[
                                                      MeetupHeaderSection(meetup: meetup),
                                                      MeetupTitleSection(meetup: meetup),
                                                      InfoSection(meetup: meetup),
                                                      Padding(padding: EdgeInsets.all(20.0), child: Text(meetup.description,style: TextStyle(fontSize: 20.0),),)]),);

                                        } else {
                                          print('initial data is null');
                                          return Container(width: 0.0,height: 0.0);
                                        }
                                  });
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:buildBody(),
      appBar:AppBar(title:Text('Meetup Details')),
      floatingActionButton: _MeetupActionButton(),
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


class _MeetupActionButton extends StatelessWidget {
  final AuthProvider auth = AuthProvider();

  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: auth.isAuthenticated(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData && snapshot.data) {
          // TODO: Check if user is meetup owner and check if user is already member
          final isMember = false;
          if (isMember) {
            return FloatingActionButton(
              onPressed: () {},
              child: Icon(Icons.cancel),
              backgroundColor: Colors.red,
              tooltip: 'Leave Meetup',
            );
          } else {
            return FloatingActionButton(
              onPressed: () {},
              child: Icon(Icons.person_add),
              backgroundColor: Colors.green,
              tooltip: 'Join Meetup',
            );
          }
        } else {
          return Container(width: 0, height: 0);
        }
      },
    );
  }
}