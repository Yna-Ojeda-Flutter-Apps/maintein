import 'package:maintein/assets/icons/home_icon_icons.dart';
import 'package:maintein/screens/assessments/assessments_list.dart';
import 'package:maintein/screens/breathing/breathing_exercise.dart';
import 'package:maintein/screens/goaltracker/goal_list.dart';
import 'package:maintein/screens/journal/journal_list.dart';
import 'package:maintein/screens/active_listening/active_list.dart';
import 'package:maintein/screens/settings.dart';
import 'package:maintein/utils/notification_helper.dart';
import 'package:maintein/utils/project_db.dart';
import 'package:flutter/material.dart';
import 'package:maintein/widgets/home/home_greeting.dart';
import 'package:maintein/widgets/home/home_menu_item.dart';
import 'package:provider/provider.dart';

class MyHome extends StatefulWidget {
  static const routeName = '/';
  final NotificationManager notifications;

  //TODO: Fix data collector and init reminders

  MyHome(this.notifications);

  @override
  State<StatefulWidget> createState() => _MyHomeState();


}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    final dao = Provider.of<ReminderDao>(context);
    final collector = Provider.of<CollectorDao>(context);
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
      body: FutureBuilder(
        future: Future.wait([
          dao.setInitialReminders(),
          widget.notifications.setInitialNotifications(),
          dao.getAllEntries(),
        ]),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if ( !snapshot.hasData ) {
            return Image(
              image: AssetImage('lib/assets/images/data/loading.png'),
              height: 300,
            );
          }
          List<Reminder> rows = snapshot.data[2];
          debugPrint(rows.toString());
          List<int> _pendingIds = [];
          for ( var request in snapshot.data[1] ) {
            _pendingIds.add(request.id);
          }
          debugPrint(_pendingIds.toString());
          return GridView.count(
            padding: EdgeInsets.all(30),
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
              FlatButton(child: Text("send data"), onPressed: () => collector.collectData(),)
            ],
          );
        },
      ),
    );
  }
}


