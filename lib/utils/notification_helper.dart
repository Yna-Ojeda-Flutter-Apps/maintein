import 'package:eit_app/utils/const_list_and_enum.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import "dart:math";

class NotificationManager {
  FlutterLocalNotificationsPlugin notificationsPlugin;
  final _random = new Random();

  NotificationManager() {
    notificationsPlugin = new FlutterLocalNotificationsPlugin();
    initNotifications();
  }
  get notificationsInstance => notificationsPlugin;
  _randomElement(List lst) => lst[_random.nextInt(lst.length)];

  void initNotifications() {
    var initializationSettingsAndroid = new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    notificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) async {
    print('Notification clicked');
    return Future.value(0);
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    return Future.value(1);
  }

  NotificationDetails _getPlatformChannelSpecifics() {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails('your other channel id', 'your other channel name', 'your other channel description');
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    NotificationDetails platformChannelSpecifics = new NotificationDetails(androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    return platformChannelSpecifics;
  }

  void scheduleGoalDueDate(int id, String title, String body, DateTime date) async {
    id = id + 100;
    await notificationsPlugin.schedule(id, title, body, date, _getPlatformChannelSpecifics());
  }

  void cancelGoalDueDate(int id) {
    id = id + 100;
    notificationsPlugin.cancel(id);
  }

  void cancelNotification(int id) {
    notificationsPlugin.cancel(id);
  }
  
  void switchNotificationPeriod(List<int> ids, Time time, String reminderType, bool isDaily) async {
    var requests = await notificationsPlugin.pendingNotificationRequests();
    List<int> pendingIds = [];
    for ( var request in requests ) {
      pendingIds.add(request.id);
    }
    ids.forEach((id){
      if ( pendingIds.contains(id)) {
        notificationsPlugin.cancel(id);
      }
    });
    if ( isDaily ) {
      showNotificationDaily(ids[0], reminderType, time);
    } else {
      ids.forEach((id) {
        int index = id % 7;
        showNotificationWeekly(id, reminderType, weekday[index], time);
      });
    }
  }

  Future<List<bool>> checkIfInPending(List<int> ids) async {
    var requests = await notificationsPlugin.pendingNotificationRequests();
    List<int> _pendingIds = [];
    List<bool> _idsInPending = [];
    for ( var request in requests ) {
      _pendingIds.add(request.id);
    }
    ids.forEach((id) {
      _idsInPending.add(_pendingIds.contains(id));
    });
    return _idsInPending;
  }

  void changeNotificationTime(List<int> ids, Time time, String reminderType, bool isDaily) async {
    var requests = await notificationsPlugin.pendingNotificationRequests();
    List<int> pendingIds = [];
    List<int> affectedIds = [];
    for ( var request in requests ) {
      pendingIds.add(request.id);
    }
    ids.forEach((id){
      if ( pendingIds.contains(id)) {
        affectedIds.add(id);
        notificationsPlugin.cancel(id);
      }
    });
    if ( isDaily ) {
      showNotificationDaily(ids[0], reminderType, time);
    } else {
      affectedIds.forEach((id) {
        showNotificationDaily(id, reminderType, time);
      });
    }
  }

  Future<bool> changeNotificationDayOfWeekly(List<int> ids, int id, Day day, Time time, String reminderType) async {
    var requests = await notificationsPlugin.pendingNotificationRequests();
    List<int> pendingIds = [];
    int idsInPending = 0;
    bool pendingStatus = pendingIds.contains(id);
    for ( var request in requests ) {
      pendingIds.add(request.id);
    }

    if ( pendingIds.contains(id) ) {
      ids.forEach((i) {
        if ( pendingIds.contains(i)) {
          idsInPending++;
        }
      });
      if ( idsInPending > 1 ) {
        notificationsPlugin.cancel(id);
        pendingStatus = false;
      }
    } else {
      showNotificationWeekly(id, reminderType, day, time);
      pendingStatus = true;
    }
    return pendingStatus;
  }

  void showNotificationDaily(
      int id, String reminderType, Time time
      ) async {
    await notificationsPlugin.showDailyAtTime(
        id, _getNotificationTitle(reminderType), _getNotificationBody(reminderType), time, _getPlatformChannelSpecifics()
    );
  }

  void showNotificationWeekly(
      int id, String reminderType, Day day, Time time
      ) async {
    await notificationsPlugin.showWeeklyAtDayAndTime(
        id, _getNotificationTitle(reminderType), _getNotificationBody(reminderType), day, time, _getPlatformChannelSpecifics()
    );
  }


  void setInitialNotifications() {
    showNotificationWeekly(0, reminderTypes[0], weekday[0], Time(8,0,0));
    for ( int i = 1; i < reminderTypes.length; i++ ) {
      showNotificationDaily(i*7, reminderTypes[i], Time(8,0,0));
    }
  }

  String _getNotificationTitle(String reminderType) {
    if (reminderType == reminderTypes[1]) {
      return _randomElement(journalReminderTitles);
    } else if (reminderType == reminderTypes[2]) {
      return "Listen to somebody today, and write about it";
    } else if (reminderType == reminderTypes[3]) {
      return _randomElement(goalTrackingReminderTitles);
    } else {
      return "Your bi-mothly assessments are ready now";
    }
  }

  String _getNotificationBody(String reminderType) {
    if (reminderType == reminderTypes[1]) {
      return "Put it in your journal";
    } else if (reminderType == reminderTypes[2]) {
      return _randomElement(activeListeningReminderBodies);
    } else if (reminderType == reminderTypes[3]) {
      return "Let's break them down the smart way.";
    } else {
      return "Take them today";
    }
  }
}

