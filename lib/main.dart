import 'package:maintein/screens/assessments/assessments_form.dart';
import 'package:maintein/screens/assessments/assessments_list.dart';
import 'package:maintein/screens/active_listening/active_list.dart';
import 'package:maintein/screens/active_listening/active_new.dart';
import 'package:maintein/screens/active_listening/active_detail.dart';
import 'package:maintein/screens/breathing/breathing_exercise.dart';
import 'package:maintein/screens/goaltracker/goal_detail.dart';
import 'package:maintein/screens/goaltracker/goal_list.dart';
import 'package:maintein/screens/home.dart';
import 'package:maintein/screens/journal/journal_detail.dart';
import 'package:maintein/screens/journal/journal_list.dart';
import 'package:maintein/screens/journal/journal_new.dart';
import 'package:maintein/screens/settings.dart';
import 'package:maintein/themes/apptheme.dart';
import 'package:maintein/utils/my_observer.dart';
import 'package:maintein/utils/notification_helper.dart';
import 'package:maintein/utils/project_db.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final NotificationManager notifications = NotificationManager();

  @override
  Widget build(BuildContext context) {
    final db = AppDatabase();
    return MultiProvider(
      providers: [
        Provider(create: (_) => db.goalDao),
        Provider(create: (_) => db.subTaskDao),
        Provider(create: (_) => db.outputDao),
        Provider(create: (_) => db.journalDao),
        Provider(create: (_) => db.assessmentDao),
        Provider(create: (_) => db.listenDao),
        Provider(create: (_) => db.reminderDao),
      ],
      child: MaterialApp(
        title: 'feelUP',
        debugShowCheckedModeBanner: false,
        theme: appTheme(),
        navigatorObservers: [MyRouteObserver()],
        home: MyHome(notifications),
        initialRoute: '/',
        routes: {
          GoalList.routeName: (context) => GoalList(notifications),
          GoalDetail.routeName: (context) => GoalDetail(notifications),
          JournalList.routeName: (context) => JournalList(),
          JournalNewForm.routeName: (context) => JournalNewForm(),
          JournalDetail.routeName: (context) => JournalDetail(),
          AssessmentsList.routeName: (context) => AssessmentsList(),
          TakeAssessment.routeName: (context) => TakeAssessment(),
          ActiveListenList.routeName: (context) => ActiveListenList(),
          ActiveListenNewForm.routeName: (context) => ActiveListenNewForm(),
          ActiveListenDetail.routeName: (context) => ActiveListenDetail(),
          BreathingExercise.routeName: (context) => BreathingExercise(),
          Settings.routeName: (context) => Settings(notifications),
        },
      ),
    );
  }

}

