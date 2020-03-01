import 'package:flutter/material.dart';
import 'package:maintein/themes/apptheme.dart';
import 'package:maintein/utils/notification_helper.dart';

class HomeMenuItem extends StatelessWidget {
  final String item;
  final String routeName;
  final IconData icon;
  final NotificationManager notifications;

  HomeMenuItem({this.item, this.routeName, this.icon, this.notifications});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        elevation: 0.0,
        child: FlatButton(
          child: Column(
            children: <Widget>[
              Icon(icon, size: 40, color: MyBlue.light,),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(item, style: Theme.of(context).textTheme.body1.copyWith(color: MyBlue.light,), textAlign: TextAlign.center,),
              ),
            ],
          ),
          onPressed: () async {
            Navigator.pushNamed(context, routeName);
          },
        )
    );
  }

}