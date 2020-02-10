import 'package:eit_app/themes/apptheme.dart';
import 'package:eit_app/utils/const_list_and_enum.dart';
import 'package:eit_app/utils/notification_helper.dart';
import 'package:eit_app/utils/project_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NotificationCard extends StatefulWidget {
  final List<int> ids;
  final Reminder reminder;
  final NotificationManager notifications;

  NotificationCard({
    this.ids,
    this.reminder,
    this.notifications,
  });
  @override
  State<StatefulWidget> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  List<bool> isIdInPending;
  @override
  Widget build(BuildContext context) {
    final dao = Provider.of<ReminderDao>(context);
    return FutureBuilder<List<bool>>(
      future: widget.notifications.checkIfInPending(widget.ids),
      builder: (BuildContext context, AsyncSnapshot<List<bool>> snapshot) {
        if ( !snapshot.hasData ) {
          return Text("loading data...");
        } else if ( snapshot.hasError ) {
          return Text("oops. error.");
        }
        isIdInPending = snapshot.data ?? List<bool>.filled(7, false);
        return Container(
          padding: EdgeInsets.only(bottom: 10.0),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey))
          ),
          child: Card(
            elevation: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(widget.reminder.type, style: Theme.of(context).textTheme.display1.copyWith(color: MyBlue.light),),
                    IconButton(
                      icon: Icon(Icons.alarm, color: MyBlue.light,),
                      iconSize: 15.0,
                      onPressed: () async {
                        showTimePicker(
                          context: context,
                          initialTime: TimeOfDay(hour: widget.reminder.time.hour, minute:widget.reminder.time.minute),
                        ).then((time) async {
                          widget.notifications.changeNotificationTime(widget.ids, Time(time.hour, time.minute), widget.reminder.type, widget.reminder.isDaily);
                          await dao.updateReminder(widget.reminder.copyWith(time: DateTime(0,1,1,time.hour, time.minute)));
                        });
                      },
                    ),
                    Text(DateFormat("h:mm a").format(widget.reminder.time), style: Theme.of(context).textTheme.subhead.copyWith(color: Colors.grey),)
                  ],
                ),
                RadioButtonGroup(
                  orientation: GroupedButtonsOrientation.HORIZONTAL,
                  onChange: (String label, int index) async {
                    bool _newPeriod = !widget.reminder.isDaily;
                    Time time = Time(widget.reminder.time.hour, widget.reminder.time.minute);
                    widget.notifications.switchNotificationPeriod(widget.ids, time, widget.reminder.type, _newPeriod);
                    await dao.updateReminder(widget.reminder.copyWith(isDaily: _newPeriod));
                  },
                  labels: periods,
                  picked: (widget.reminder.isDaily) ? periods[0] : periods[1],
                  itemBuilder: (Radio button, Text text, int index) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        button, text
                      ],
                    );
                  },
                ),
                (widget.reminder.isDaily ) ? Container() : Table(
                  children: [
                    TableRow(
                        children: [
                          FlatButton(
                            shape: CircleBorder(),
                            color: (isIdInPending[0]) ? MyBlue.picton : Colors.grey,
                            child: Text('S', style: TextStyle(color: Colors.white),),
                            onPressed: () async {
                              var pendingStatus = await widget.notifications.changeNotificationDayOfWeekly(
                                  widget.ids, widget.ids[0], weekday[0],
                                  Time(widget.reminder.time.hour, widget.reminder.time.minute), widget.reminder.type
                              );
                              setState(() {
                                isIdInPending[0] = pendingStatus;
                              });
                            },
                          ),
                          FlatButton(
                            shape: CircleBorder(),
                            color: (isIdInPending[1]) ? MyBlue.picton : Colors.grey,
                            child: Text('M', style: TextStyle(color: Colors.white),),
                            onPressed: () async {
                              var pendingStatus = await widget.notifications.changeNotificationDayOfWeekly(
                                  widget.ids, widget.ids[1], weekday[1],
                                  Time(widget.reminder.time.hour, widget.reminder.time.minute),
                                  widget.reminder.type
                              );
                              setState(() {
                                isIdInPending[1] = pendingStatus;
                              });
                            },
                          ),
                          FlatButton(
                            shape: CircleBorder(),
                            color: (isIdInPending[2]) ? MyBlue.picton : Colors.grey,
                            child: Text('T', style: TextStyle(color: Colors.white),),
                            onPressed: () async {
                              var pendingStatus = await widget.notifications.changeNotificationDayOfWeekly(
                                  widget.ids, widget.ids[2], weekday[2],
                                  Time(widget.reminder.time.hour, widget.reminder.time.minute),
                                  widget.reminder.type
                              );
                              setState(() {
                                isIdInPending[2] = pendingStatus;
                              });
                            },
                          ),
                          FlatButton(
                            shape: CircleBorder(),
                            color: (isIdInPending[3]) ? MyBlue.picton : Colors.grey,
                            child: Text('W', style: TextStyle(color: Colors.white),),
                            onPressed: () async {
                              var pendingStatus = await widget.notifications.changeNotificationDayOfWeekly(
                                  widget.ids, widget.ids[3], weekday[3],
                                  Time(widget.reminder.time.hour, widget.reminder.time.minute),
                                  widget.reminder.type
                              );
                              setState(() {
                                isIdInPending[3] = pendingStatus;
                              });
                            },
                          ),
                          FlatButton(
                            shape: CircleBorder(),
                            color: (isIdInPending[4]) ? MyBlue.picton : Colors.grey,
                            child: Text('T', style: TextStyle(color: Colors.white),),
                            onPressed: () async {
                              var pendingStatus = await widget.notifications.changeNotificationDayOfWeekly(
                                  widget.ids, widget.ids[4], weekday[4],
                                  Time(widget.reminder.time.hour, widget.reminder.time.minute),
                                  widget.reminder.type
                              );
                              setState(() {
                                isIdInPending[4] = pendingStatus;
                              });
                            },
                          ),
                          FlatButton(
                            shape: CircleBorder(),
                            color: (isIdInPending[5]) ? MyBlue.picton : Colors.grey,
                            child: Text('F', style: TextStyle(color: Colors.white),),
                            onPressed: () async {
                              var pendingStatus = await widget.notifications.changeNotificationDayOfWeekly(
                                  widget.ids, widget.ids[5], weekday[5],
                                  Time(widget.reminder.time.hour, widget.reminder.time.minute),
                                  widget.reminder.type
                              );
                              setState(() {
                                isIdInPending[5] = pendingStatus;
                              });
                            },
                          ),
                          FlatButton(
                            shape: CircleBorder(),
                            color: (isIdInPending[6]) ? MyBlue.picton : Colors.grey,
                            child: Text('S', style: TextStyle(color: Colors.white),),
                            onPressed: () async{
                              var pendingStatus = await widget.notifications.changeNotificationDayOfWeekly(
                                  widget.ids, widget.ids[6], weekday[6],
                                  Time(widget.reminder.time.hour, widget.reminder.time.minute), widget.reminder.type
                              );
                              setState(() {
                                isIdInPending[6] = pendingStatus;
                              });
                            },
                          ),
                        ]
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}