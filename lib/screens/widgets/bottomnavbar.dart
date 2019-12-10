import 'package:eit_app/screens/breathing/breathing_exercise.dart';
import 'package:eit_app/screens/home.dart';
import 'package:flutter/material.dart';

BottomNavigationBar bottomNavBar(BuildContext context) {
  return BottomNavigationBar(
    backgroundColor: Colors.white,
    selectedItemColor: Colors.grey[600],
    unselectedItemColor: Colors.grey[600],
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('Home')
      ),
      BottomNavigationBarItem(
          icon: Icon(Icons.alarm_on),
          title: Text('Trigger')
      ),
      BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          title: Text('Settings')
      ),
    ],
    onTap: (value) {
      if (value == 0) {
        Navigator.pushNamed(context, MyHome.routeName);
      } else if ( value == 1 ) {
        Navigator.pushNamed(context, BreathingExercise.routeName);
      }
    },
  );
}