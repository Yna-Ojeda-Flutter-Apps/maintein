import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:maintein/screens/home.dart';
import 'package:maintein/themes/apptheme.dart';
import 'package:maintein/utils/notification_helper.dart';
import 'package:maintein/utils/project_db.dart';
import 'package:maintein/widgets/onboarding_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class OnBoarding extends StatefulWidget {
  static const String routeName = "/onboarding";
  final NotificationManager notifications;

  OnBoarding(this.notifications);
  @override
  State<StatefulWidget> createState() => _OnBoardingState();

}

class _OnBoardingState extends State<OnBoarding>{
  final int _totalPages = 6;
  final PageController _pageController = PageController(initialPage: 0);
  int _pageIndex = 0;
  String bottomButtonText = "next";

  @override
  Widget build(BuildContext context) {
    final dao = Provider.of<ReminderDao>(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        bottomNavigationBar: (_pageIndex == (_totalPages -1)) ? Padding(
          padding: EdgeInsets.all(20),
          child: FlatButton(
            child: Text("Let's get started!", style: Theme.of(context).textTheme.button.copyWith(color: Colors.white)),
            color: MyBlue.picton,
            onPressed: () async {
              await dao.setInitialReminders();
              await widget.notifications.setInitialNotifications();
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setBool("toOnboardingPage", false);
              Navigator.pushNamed(context, MyHome.routeName);
            },
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
          ),
        ) : null,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: _pageIndicator(_pageIndex),
        ),
        body: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: PageView(
              scrollDirection: Axis.horizontal,
              controller: _pageController,
              children: <Widget>[
                OnBoardingPage(
                  title: "Welcome to Maintein",
                  subtitle: "Maintain your mental well being through the following exercises that strengthen your emotional intelligence.",
                  imagePath: "lib/assets/images/welcome.png",
                ),
                OnBoardingPage(
                  title: "Reflective Journaling",
                  subtitle: "Journal your thoughts and reflections daily or weekly. Don't know what to write about? We've got you covered with prompts!",
                  imagePath: "lib/assets/images/data/content.png",
                ),
                OnBoardingPage(
                  title: "Active Listening",
                  subtitle: "A checklist to be more mindful of how well you listen to others during conversations. Conversation starters and prompts are available as well!",
                  imagePath: "lib/assets/images/data/converse.png",
                ),
                OnBoardingPage(
                  title: "Goal Setting",
                  subtitle: "Plan your tasks and goals the smart way. Break them down into subtasks, set reminders, and more!",
                  imagePath: "lib/assets/images/data/goals.png",
                ),
                OnBoardingPage(
                  title: "Tracking Well-being",
                  subtitle: "Take the assessments weekly or daily. Monitor your mental well-being and emotional intelligence!",
                  imagePath: "lib/assets/images/data/monitor.png",
                ),
                OnBoardingPage(
                  title: "Maintein: Research Version",
                  subtitle: "The version of Maintein you are currently using is for research purposes. By clicking 'Let's get started', you confirm that you are one of the research participants that have been briefed, have signed the consent form, and have agreed to participate.",
                  imagePath: "lib/assets/images/notify.png",
                ),
              ],
              onPageChanged: (value){
                setState(() {
                  _pageIndex = value;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
  _pageIndicator(int currentPage) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: DotsIndicator(
        dotsCount: _totalPages,
        decorator: DotsDecorator(activeColor: MyBlue.seagull),
        position: currentPage.toDouble(),
      ),
    );
  }
}