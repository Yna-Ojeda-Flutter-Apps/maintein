import 'package:maintein/themes/apptheme.dart';
import 'package:maintein/utils/const_list_and_enum.dart';
import 'package:maintein/utils/notification_helper.dart';
import 'package:maintein/utils/project_db.dart';
import 'package:maintein/widgets/bottomnavbar.dart';
import 'package:maintein/widgets/my_app_bar.dart';
import 'package:maintein/widgets/settings/notification_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class NotificationSetting extends StatefulWidget {
  static final String routeName = "/notifications";
  final NotificationManager notifications;

  NotificationSetting(this.notifications);

  @override
  State<StatefulWidget> createState() => _NotificationSettingState();

}

class _NotificationSettingState extends State<NotificationSetting>{
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
            child: Text("Notifications", style: Theme.of(context).textTheme.title.copyWith(color: MyBlue.light),),
            onPressed: null,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: dao.watchAllEntries(),
        builder: (context, AsyncSnapshot<List<Reminder>> snapshot) {
          if ( !snapshot.hasData ) {
            return Center(
              child:CircularProgressIndicator(),
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