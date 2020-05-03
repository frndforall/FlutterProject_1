import 'package:flutter/material.dart';


class BottomNavigation extends StatefulWidget {
  
  _BottomNavigation createState() => _BottomNavigation();
}


class _BottomNavigation extends State<BottomNavigation> {
  int _currentIndex =0;
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex:_currentIndex,
      onTap: (int index) {
       // _currentIndex = index;
       print(index);
       setState(() {
         _currentIndex=index;
       });
      },
      
      items: [BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),BottomNavigationBarItem(icon: Icon(Icons.person),title: Text('Profile')),
                                                            BottomNavigationBarItem(icon: Icon(Icons.settings), title: Text('Settings'))]);
  }
}