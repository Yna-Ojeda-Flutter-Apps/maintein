import 'package:maintein/assets/icons/home_icon_icons.dart';
import 'package:maintein/screens/assessments/assessments_list.dart';
import 'package:maintein/screens/breathing/breathing_exercise.dart';
import 'package:maintein/screens/goaltracker/goal_list.dart';
import 'package:maintein/screens/journal/journal_list.dart';
import 'package:maintein/screens/active_listening/active_list.dart';
import 'package:maintein/screens/settings.dart';
import 'package:maintein/themes/apptheme.dart';
import 'package:maintein/utils/notification_helper.dart';
import 'package:maintein/utils/project_db.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    final dao = Provider.of<ReminderDao>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150.0),
        child: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.elliptical(300, 150))
          ),
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: EdgeInsets.zero,
            centerTitle: true,
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                _greeting(),
                _headline(context),
              ],
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: Future.wait([
          dao.getAllEntries()
        ]),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if ( !snapshot.hasData ) {
            return Image(
              image: AssetImage('lib/assets/images/data/loading.png'),
              height: 300,
            );
          }
          List<Reminder> rows = snapshot.data[0];
          if ( rows.length < 1 ) {
            dao.initializeReminders();
            widget.notifications.setInitialNotifications();
          }
          debugPrint(rows.toString());
          return _appMenu(context);
        },
      ),
    );
  }

  Padding _greeting() {
    return Padding(
      padding: EdgeInsets.only(top: 70.0, bottom: 0.0, right: 20, left: 20),
      child: Text(
        'Hello, there.',
        style: TextStyle(
            fontFamily: 'Raleway',
            fontSize: 30,
            color: Colors.white
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
  Padding _headline(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 0.0, bottom: 0.0, right: 20, left: 20),
      child: Text(
        'What do you wish to do?',
        style: Theme.of(context).textTheme.title.copyWith(color: Colors.white),
        textAlign: TextAlign.center,
      ),
    );
  }
  GridView _appMenu(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.all(50),
      crossAxisSpacing: 50,
      mainAxisSpacing: 20,
      crossAxisCount: 2,
      children: <Widget>[
        _createMenuItem(context, 'Reflective Journal', HomeIcon.diary, JournalList.routeName),
        _createMenuItem(context, 'Listening Checker', HomeIcon.conversation, ActiveListenList.routeName),
        _createMenuItem(context, 'Goal Tracking', HomeIcon.target, GoalList.routeName),
        _createMenuItem(context, 'Assessments', HomeIcon.test, AssessmentsList.routeName),
        _createMenuItem(context, 'Settings & Notifications', HomeIcon.settings, Settings.routeName),
        _createMenuItem(context, 'Breathing Guide', HomeIcon.calm, BreathingExercise.routeName),
      ],
    );
  }
  Card _createMenuItem(BuildContext context, String item, IconData icon, String routeName) {
    return Card(
        color: Colors.white,
        elevation: 0.0,
        child: FlatButton(
          child: Column(
            children: <Widget>[
              Icon(icon, size: 40, color: MyBlue.light,),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(item, style: Theme.of(context).textTheme.button.copyWith(color: MyBlue.light,), textAlign: TextAlign.center,),
              ),
            ],
          ),
          onPressed: () {
            Navigator.pushNamed(context, routeName);
          },
        )
    );
  }

}


