import 'package:maintein/assets/icons/home_icon_icons.dart';
import 'package:maintein/screens/home.dart';
import 'package:maintein/themes/apptheme.dart';
import 'package:flutter/material.dart';


class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 10.0,
      shape: CircularNotchedRectangle(),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          IconButton(
            icon: Icon(HomeIcon.home, size: 30.0, color: MyBlue.light,),
            onPressed: () => Navigator.pushNamed(context, MyHome.routeName),
          ),
          IconButton(
            icon: Icon(HomeIcon.calm, size: 30.0, color: MyBlue.light),
            onPressed: () => Navigator.pushNamed(context, MyHome.routeName),
          ),
        ],
      ),
    );
  }
}


