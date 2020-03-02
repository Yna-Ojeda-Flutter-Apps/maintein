import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:maintein/screens/settings/about_the_app.dart';
import 'package:maintein/screens/settings/notification_settings.dart';
import 'package:maintein/screens/settings/resource_attributions.dart';
import 'package:maintein/themes/apptheme.dart';
import 'package:maintein/utils/notification_helper.dart';
import 'package:maintein/widgets/bottomnavbar.dart';
import 'package:maintein/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';


class Settings extends StatefulWidget {
  static final String routeName = "/settings";
  final NotificationManager notifications;
  //TODO: Add notifications, app guide, and attributions

  Settings(this.notifications);
  @override
  State<StatefulWidget> createState() => _SettingsState();

}

class _SettingsState extends State<Settings>{
  String _participantID = "\nYour Unique Participant Id";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      bottomNavigationBar: BottomNavBar(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: MyAppBar(
          flexibleSpaceChild: FlatButton(
            child: Text("Settings", style: Theme.of(context).textTheme.title.copyWith(color: MyBlue.light),),
            onPressed: null,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 10),
        child: ListView(
          children: ListTile.divideTiles(color: Colors.grey, tiles: [
            ListTile(
              title: Text("Notifications", style: Theme.of(context).textTheme.subhead.copyWith(color: MyBlue.light),),
              subtitle: Text("Set your notifications to weekly or daily."),
              onTap: () => Navigator.pushNamed(context, NotificationSetting.routeName),
            ),
            ListTile(
              title: Text("About the App", style: Theme.of(context).textTheme.subhead.copyWith(color: MyBlue.light),),
              subtitle: Text("Check our references and find out how to contact us."),
              onTap: () => Navigator.pushNamed(context, AboutTheApp.routeName),
            ),
            ListTile(
              title: Text("Attributions", style: Theme.of(context).textTheme.subhead.copyWith(color: MyBlue.light),),
              subtitle: Text("See where we got our awesome reasources."),
              onTap: () => Navigator.pushNamed(context, ResourceAttribution.routeName),
            ),
            ListTile(
              title: SelectableText(_participantID, style: Theme.of(context).textTheme.subhead.copyWith(color: MyBlue.light),),
              subtitle: Text("All data collected from you is identified by this string. Please do not share to anyone."),
              onTap: () async {
                DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
                String _identifier;
                if ( Platform.isAndroid ) {
                  AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
                  _identifier = androidInfo.androidId;
                } else if ( Platform.isIOS ) {
                  IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
                  _identifier = iosDeviceInfo.identifierForVendor;
                } else {
                  _identifier = "Could not identify";
                }
                setState(() {
                  _participantID = "\n" + _identifier;
                });
                Future.delayed(Duration(seconds: 10),(){
                  setState(() {
                    _participantID = "\nYour Unique Participant ID";
                  });
                });
              },
            )
          ]).toList(),
        ),
      ),
    );
  }
}