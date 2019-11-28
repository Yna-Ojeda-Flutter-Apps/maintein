import 'package:flutter/material.dart';

BottomNavigationBar bottomNavBar() {
  return BottomNavigationBar(
    backgroundColor: Colors.white,
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
  );
}