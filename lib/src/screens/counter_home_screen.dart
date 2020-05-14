
import 'package:flutter/material.dart';
import 'package:myhomeapp/src/blocs/counter_bloc.dart';
import 'package:myhomeapp/src/screens/meetup_home_screen.dart';
import 'package:myhomeapp/src/screens/posts_screen.dart';
import 'package:myhomeapp/src/widgets/bottom_navigation_design.dart';



class HomeScreen extends StatefulWidget{
  final String title;
  final CounterBloc counterBloc;
  HomeScreen({this.title, this.counterBloc});
  @override
  State<StatefulWidget> createState() => HomeScreenState();
  

}

class HomeScreenState extends State<HomeScreen>   {

  @override
  dispose() {
   widget.counterBloc.dispose();
    super.dispose();
  }

  didChangeDependencies() {
    super.didChangeDependencies();
    //counterBloc = CounterBlocProvider.of(context);
  }

  _increment() {
        widget.counterBloc.incrementer(15); 
      }

  Widget build(BuildContext context) {
   return Scaffold(body: Center(child: Column(
     mainAxisAlignment:MainAxisAlignment.center,
     children: <Widget>[Text('Welcome to Business App',textDirection: TextDirection.ltr,style:TextStyle(fontSize: 30.0)
     ),

      StreamBuilder(stream: widget.counterBloc.counterstream,
      builder: (BuildContext context, AsyncSnapshot<int>  snapshot) {
          if(snapshot.hasData) {
            return Text('Counter is : ${snapshot.data}',
                 textDirection: TextDirection.ltr,
                style:TextStyle(fontSize: 24.0)
                );
          } else {
            return  Text('Counter is bad',
                 textDirection: TextDirection.ltr,
                style:TextStyle(fontSize: 24.0)
                );
          }
      },),
       RaisedButton(
         child:  StreamBuilder(stream: widget.counterBloc.counterstream,
      builder: (BuildContext context, AsyncSnapshot<int>  snapshot) {
          if(snapshot.hasData) {
            return Text('Counter is : ${snapshot.data}',
                 textDirection: TextDirection.ltr,
                style:TextStyle(fontSize: 24.0)
                );
          } else {
            return  Text('Counter is bad',
                 textDirection: TextDirection.ltr,
                style:TextStyle(fontSize: 24.0)
                );
          }
      },),
         onPressed: (){
           Navigator.pushNamed(context, MeetUpHomeScreen.route);
         },
       ), RaisedButton(
         child: Text('Go To Post Screen'),
         onPressed: (){
           Navigator.pushNamed(context, PostScreen.route);
         },
       )
       ],
   )
        ),
        floatingActionButton: FloatingActionButton(onPressed: _increment,
        child: Icon(Icons.add),
        tooltip: 'Click to increase'),
          appBar: AppBar(title:Text(widget.title)),
          bottomNavigationBar: BottomNavigation()
        );
  }

}
