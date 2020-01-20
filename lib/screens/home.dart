import 'package:eit_app/screens/assessments/assessments_list.dart';
import 'package:eit_app/screens/goaltracker/goal_list.dart';
import 'package:eit_app/screens/journal/journal_list.dart';
import 'package:eit_app/screens/active_listening/active_list.dart';
import 'package:flutter/material.dart';
import 'package:eit_app/assets/icons/home_icons_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
class MyHome extends StatelessWidget {
  static const routeName = '/my_home';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0xff21BEDE),
//      appBar: AppBar(
//        title: Text(''),
//      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _headline(),
          _appMenu(context),
        ],
      ),
//      bottomNavigationBar: _bottomNavBar(),
    );
  }
  Padding _headline() {
    return Padding(
      padding: EdgeInsets.only(top: 70, left: 50, right: 50),
      child: Text(
        'Hello, there. What do you wish to do?',
        style: TextStyle(
          fontFamily: 'Raleway',
//            fontWeight: FontWeight.w700,
          fontSize: 50.0,
          color: Colors.white,

        ),
      ),
    );
  }
  Expanded _appMenu(BuildContext context) {
    return Expanded(
      child: GridView.count(
        padding: EdgeInsets.all(50),
        crossAxisSpacing: 50,
        mainAxisSpacing: 20,
        crossAxisCount: 2,
        children: <Widget>[
          Card(
              color: Colors.white,
              shape: CircleBorder(),
              child: IconButton(
                icon: Icon(HomeIcons.test, size: 50, color: Color(0xFF21BEDE),),
                onPressed: () {
                  Navigator.pushNamed(context, AssessmentsList.routeName);
                },
                tooltip: 'Assessments',
              )
          ),
          Card(
              color: Colors.white,
              shape: CircleBorder(),
              child: IconButton(
                icon: Icon(HomeIcons.diary, size: 50, color: Color(0xFF21BEDE),),
                onPressed: () {
                  Navigator.pushNamed(context, JournalList.routeName);
                },
                tooltip: 'Reflective Journal',
              )
          ),
          Card(
              color: Colors.white,
              shape: CircleBorder(),
              child: IconButton(
                icon: Icon(HomeIcons.conversation, size: 50, color: Color(0xFF21BEDE),),
                onPressed: () {
                  Navigator.pushNamed(context, ActiveListenList.routeName);
                },
                tooltip: 'Active Listening Checker',
              )
          ),
          Card(
              color: Colors.white,
              shape: CircleBorder(),
              child: IconButton(
                icon: Icon(HomeIcons.target, size: 50, color: Color(0xFF21BEDE),),
                onPressed: () {
                  Navigator.pushNamed(context, GoalList.routeName);
                },
                tooltip: 'Goal Tracker',
              )
          ),
        ],
      ),
    );
  }
}

