import 'package:eit_app/screens/goaltracker/goal_detail.dart';
import 'package:eit_app/screens/goaltracker/goal_list.dart';
import 'package:eit_app/screens/home.dart';
//import 'package:eit_app/screens/widgets/screen_arguments.dart';
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
        Provider(builder: (__) => db.goalDao),
        Provider(builder: (_) => db.subTaskDao),
        Provider(builder: (_) => db.outputDao),
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
        },
      ),
    );
  }

}
