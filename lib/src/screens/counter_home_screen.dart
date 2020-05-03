import 'package:flutter/material.dart';
import 'package:myhomeapp/widgets/bottom_navigation_design.dart';


class HomeScreen extends StatefulWidget{
  String _title;
  HomeScreen(String title) {
    _title = title;
  }
  @override
  State<StatefulWidget> createState() => HomeScreenState();
  

}

class HomeScreenState extends State<HomeScreen>   {
  
  int increment =0;


  _increment() {
            // increment++;
            setState(() {
                increment++;
            });
            
        }

  Widget build(BuildContext context) {
   return Scaffold(body: Center(child: Column(
     mainAxisAlignment:MainAxisAlignment.center,
     children: <Widget>[Text('Welcome to Business App',textDirection: TextDirection.ltr,style:TextStyle(fontSize: 30.0)
     ),
       Text('Counter is : $increment',
           textDirection: TextDirection.ltr,
          style:TextStyle(fontSize: 24.0)

       ),
       RaisedButton(
         child: Text('Go To Details'),
         onPressed: (){
           Navigator.pushNamed(context, '/meetupDetail');
         },
       )
       ],
   )
        ),
        floatingActionButton: FloatingActionButton(onPressed: _increment,
        child: Icon(Icons.add),
        tooltip: 'Click to increase'),
          appBar: AppBar(title:Text(widget._title)),
          bottomNavigationBar: BottomNavigation()
        );
  }

}
