import 'package:maintein/assets/icons/home_icon_icons.dart';
import 'package:maintein/screens/assessments/assessments_list.dart';
import 'package:maintein/screens/breathing/breathing_exercise.dart';
import 'package:maintein/screens/goaltracker/goal_list.dart';
import 'package:maintein/screens/journal/journal_list.dart';
import 'package:maintein/screens/active_listening/active_list.dart';
import 'package:maintein/screens/settings/settings.dart';
import 'package:maintein/utils/notification_helper.dart';
import 'package:flutter/material.dart';
import 'package:maintein/widgets/home/home_greeting.dart';
import 'package:maintein/widgets/home/home_menu_item.dart';

class MyHome extends StatefulWidget {
  static const routeName = '/';
  final NotificationManager notifications;


  MyHome(this.notifications);

  @override
  State<StatefulWidget> createState() => _MyHomeState();


}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.elliptical(300, 150))
          ),
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: EdgeInsets.zero,
            centerTitle: true,
            title: HomeGreeting(),
          ),
        ),
      ),
      body: GridView.count(
        padding: EdgeInsets.only(top: 40, left: 15, right: 15, bottom: 10),
        crossAxisSpacing: 50,
        mainAxisSpacing: 20,
        crossAxisCount: 2,
        children: <Widget>[
          HomeMenuItem(
            item: 'Reflective Journal',
            routeName: JournalList.routeName,
            icon: HomeIcon.diary,
          ),
          HomeMenuItem(
            item: 'Listening Checker',
            routeName: ActiveListenList.routeName,
            icon: HomeIcon.conversation,
          ),
          HomeMenuItem(
            item: 'Goal Tracking',
            routeName:  GoalList.routeName,
            icon: HomeIcon.target,
          ),
          HomeMenuItem(
            item: 'Assessments',
            routeName: AssessmentsList.routeName,
            icon: HomeIcon.test,
          ),
          HomeMenuItem(
            item: 'Settings & Notifications',
            routeName: Settings.routeName,
            icon: HomeIcon.settings,
          ),
          HomeMenuItem(
            item: 'Breathing Guide',
            routeName: BreathingExercise.routeName,
            icon: HomeIcon.calm,
          ),
        ],
      ),
    );
  }
}


