import 'package:maintein/assets/icons/home_icon_icons.dart';
import 'package:maintein/screens/breathing/breathing_exercise.dart';
import 'package:maintein/screens/home.dart';
import 'package:maintein/themes/apptheme.dart';
import 'package:flutter/material.dart';
import 'package:maintein/utils/project_db.dart';
import 'package:provider/provider.dart';


class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dao = Provider.of<CollectorDao>(context);
    return BottomAppBar(
      elevation: 10.0,
      shape: CircularNotchedRectangle(),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Tooltip(
            message: "Home",
            child: IconButton(
                icon: Icon(HomeIcon.home, size: 30.0, color: MyBlue.light,),
                onPressed: () async {
                  Navigator.pushNamed(context, MyHome.routeName);
                  await dao.collectData();
                }
            ),
          ),
          Tooltip(
            message: "Breathing Guide",
            child: IconButton(
              icon: Icon(HomeIcon.calm, size: 30.0, color: MyBlue.light),
              onPressed: () => Navigator.pushNamed(context, BreathingExercise.routeName),
            ),
          ),
        ],
      ),
    );
  }
}


