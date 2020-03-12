import 'package:maintein/assets/icons/home_icon_icons.dart';
import 'package:maintein/screens/home.dart';
import 'package:maintein/screens/breathing/hotlines.dart';
import 'package:maintein/themes/apptheme.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
class BreathingExercise extends StatefulWidget {
  static const routeName = '/breathe';

  @override
  State<StatefulWidget> createState() {
    return BreathingState();
  }
}

class BreathingState extends State<BreathingExercise> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image(
          image: AssetImage('lib/assets/images/breathing.gif'),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
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
                  }
              ),
            ),
            Tooltip(
              message: "Hotline Information",
              child: IconButton(
                icon: Icon(Icons.info_outline, size: 30.0, color: MyBlue.light),
                onPressed: () => Navigator.pushNamed(context, HotlinesList.routeName),
              ),
            )
          ],
        ),
      ),
    );
  }

}