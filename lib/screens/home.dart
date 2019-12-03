import 'package:flutter/material.dart';
import 'package:eit_app/home_icons_icons.dart';
class MyHome extends StatelessWidget {
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
//                  Navigator.pushNamed(context, '/goal_list');
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
                  Navigator.pushNamed(context, '/journal_list');
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
                  Navigator.pushNamed(context, '/listen_list');
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
                  Navigator.pushNamed(context, '/goal_list');
                },
                tooltip: 'Goal Tracker',
              )
          ),
        ],
      ),
    );
  }
}

