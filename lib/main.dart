import 'package:eit_app/screens/assessments/assessments_form.dart';
import 'package:eit_app/screens/assessments/assessments_list.dart';
import 'package:eit_app/screens/active_listening/active_list.dart';
import 'package:eit_app/screens/active_listening/active_new.dart';
import 'package:eit_app/screens/active_listening/active_detail.dart';
import 'package:eit_app/screens/goaltracker/goal_detail.dart';
import 'package:eit_app/screens/goaltracker/goal_list.dart';
import 'package:eit_app/screens/home.dart';
import 'package:eit_app/screens/journal/journal_detail.dart';
import 'package:eit_app/screens/journal/journal_list.dart';
import 'package:eit_app/screens/journal/journal_new.dart';
import 'package:eit_app/themes/apptheme.dart';
import 'package:eit_app/utils/project_db.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final db = AppDatabase();
    return MultiProvider(
      providers: [
        Provider(create: (__) => db.goalDao),
        Provider(create: (_) => db.subTaskDao),
        Provider(create: (_) => db.outputDao),
        Provider(create: (_) => db.journalDao),
        Provider(create: (_) => db.assessmentDao),
        Provider(create: (_) => db.listenDao),
      ],
      child: MaterialApp(
        title: 'feelUP',
        debugShowCheckedModeBanner: false,
        theme: appTheme(),
        home: MyHome(),
        initialRoute: '/',
        routes: {
          GoalList.routeName: (context) => GoalList(),
          GoalDetail.routeName: (context) => GoalDetail(),
          JournalList.routeName: (context) => JournalList(),
          JournalNewForm.routeName: (context) => JournalNewForm(),
          JournalDetail.routeName: (context) => JournalDetail(),
          AssessmentsList.routeName: (context) => AssessmentsList(),
          TakeAssessment.routeName: (context) => TakeAssessment(),
          ActiveListenList.routeName: (context) => ActiveListenList(),
          ActiveListenNewForm.routeName: (context) => ActiveListenNewForm(),
          ActiveListenDetail.routeName: (context) => ActiveListenDetail(),
        },
      ),
    );
  }

}

