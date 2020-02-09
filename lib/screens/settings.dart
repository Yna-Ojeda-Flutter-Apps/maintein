import 'package:eit_app/themes/apptheme.dart';
import 'package:eit_app/utils/const_list_and_enum.dart';
import 'package:eit_app/utils/notification_helper.dart';
import 'package:eit_app/utils/project_db.dart';
import 'package:eit_app/widgets/bottomnavbar.dart';
import 'package:eit_app/widgets/my_app_bar.dart';
import 'package:eit_app/widgets/settings/notification_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';


class Settings extends StatefulWidget {
  static final String routeName = "/settings";
  final NotificationManager notifications;

  Settings(this.notifications);
  @override
  State<StatefulWidget> createState() => _SettingsState();

}

class _SettingsState extends State<Settings>{
  @override
  Widget build(BuildContext context) {
    final dao = Provider.of<ReminderDao>(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      bottomNavigationBar: BottomNavBar(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: MyAppBar(
          flexibleSpaceChild: FlatButton(
            child: Text("Settings & Notifications", style: Theme.of(context).textTheme.title.copyWith(color: MyBlue.light),),
            onPressed: null,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: dao.watchAllEntries(),
        builder: (context, AsyncSnapshot<List<Reminder>> snapshot) {
          if ( !snapshot.hasData ) {
            return Image(
              image: AssetImage('lib/assets/images/data/loading.png'),
              height: 300,
            );
          }
          List<Reminder> records = snapshot.data;
          return Padding(
            padding: EdgeInsets.all(10.0),
            child: CustomScrollView(
              slivers: <Widget>[
                SliverList(delegate: SliverChildListDelegate([
                  NotificationCard(
                    reminder: records[0],
                    ids: notificationIndices[0],
                    notifications: widget.notifications,
                  ),
                  NotificationCard(
                    reminder: records[1],
                    ids: notificationIndices[1],
                    notifications: widget.notifications,
                  ),
                  NotificationCard(
                    reminder: records[2],
                    ids: notificationIndices[2],
                    notifications: widget.notifications,
                  ),
                  NotificationCard(
                    reminder: records[3],
                    ids: notificationIndices[3],
                    notifications: widget.notifications,
                  ),
                ]),)
              ],
            ),
          );
        },
      ),
    );
  }
}