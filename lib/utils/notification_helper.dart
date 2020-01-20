import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import "dart:math";

class NotificationManager {
  var notificationsPlugin;
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
    await notificationsPlugin.showWeeklyAtDayandTime(
      id, _getNotificationTitle(reminderType), _getNotificationBody(reminderType), day, time, _getPlatformChannelSpecifics()
    );
  }

  String _getNotificationTitle(String reminderType) {
    if (reminderType == 'RJW') {
      return _randomElement(_journalReminderTitles);
    } else if (reminderType == 'AL') {
      return "Listen to somebody today, and write about it";
    } else if (reminderType == 'GT') {
      return _randomElement(_goalTrackingReminderTitles);
    } else {
      return "Your bi-mothly assessments are ready now";
    }
  }

  String _getNotificationBody(String reminderType) {
    if (reminderType == 'RJW') {
      return "Put it in your journal";
    } else if (reminderType == 'AL') {
      return _randomElement(_activeListeningReminderBodies);
    } else if (reminderType == 'GT') {
      return "Let's break them down the smart way.";
    } else {
      return "Take them today";
    }
  }
}

final _journalReminderTitles = [
  "What's happened recently?",
  "What's the most interesting thing you've done recently?",
  "How has your day been?",
  "How has your week been?",
  "Share some of your thoughts recently",
  "Share what you've been feeling as of late",
  "Write about something that made you feel recently",
  "What have you been doing lately?",
  "Share something you want to do differently",
  "Write anything about your day",
  "What could make tomorrow better?",
  "How could have today been better?",
  "How have you been making others feel lately?",
  "How stressful have you been recently?"
];

final _activeListeningReminderBodies = [
  "Remember to be mindful of your postures when listening",
  "Remember to use nods and gestures to show engagement",
  "Remember to use appropriate facial expression",
  "Remember to check if you've understood by paraphrasing",
  "Remember to give minimal verbal encouragers",
  "Remember to ask infrequent and considered questions",
  "Remember to allow attentive silences",
  "Try to pick up on the speaker's feelings when you do",
  "Remember to summarize the speaker's major issues or points",
  "Avoid judging or criticizing the speaker when you do",
  "Don't avoid the speaker's concern when you do",
  "Avoid moralizing or advising the speaker when you do"
];

final _goalTrackingReminderTitles = [
  "What are your plans for today?",
  "What are your plans for the week?",
  "What do you want to achieve today?",
  "What do you want to achieve this week?"
];

