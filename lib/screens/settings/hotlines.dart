import 'package:flutter/material.dart';
import 'package:maintein/themes/apptheme.dart';
import 'package:maintein/widgets/bottomnavbar.dart';
import 'package:maintein/widgets/my_app_bar.dart';

class HotlinesList extends StatelessWidget {
  static const routeName = '/hotlines';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      bottomNavigationBar: BottomNavBar(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: MyAppBar(
          flexibleSpaceChild: FlatButton(
            child: Text("Hotlines", style: Theme.of(context).textTheme.title.copyWith(color: MyBlue.light),),
            onPressed: null,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: ListView(
          children: <Widget>[
            Text("UP PsycServ",
              style: Theme.of(context).textTheme.subhead.copyWith(color: MyBlue.light),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: SelectableText.rich(
                TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: "981-8500 loc, 2496\n"),
                      TextSpan(text: "0916-757-3157\n"),
                    ]
                ),
              ),
            ),
            Text("New National Center for Mental Health (NCMH) Crisis Hotlines",
              style: Theme.of(context).textTheme.subhead.copyWith(color: MyBlue.light),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: SelectableText.rich(
                TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: "0917 899 8727\n"),
                      TextSpan(text: "989 8727\n"),
                      TextSpan(text: "0949 143 6425\n"),
                      TextSpan(text: "0915 792 6889\n"),
                      TextSpan(text: "0922 241 3855\n"),
                      TextSpan(text: "(02) 531 9001\n"),
                    ]
                ),
              ),
            ),
            Text("Natasha Goulbourn Foundation",
              style: Theme.of(context).textTheme.subhead.copyWith(color: MyBlue.light),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: SelectableText.rich(
                TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: "0917 558 4673\n"),
                      TextSpan(text: "(02) 804-4673\n"),
                    ]
                ),
              ),
            ),
            Text("Manila Lifeline Centre",
              style: Theme.of(context).textTheme.subhead.copyWith(color: MyBlue.light),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: SelectableText.rich(
                TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: "(02) 896 9191\n"),
                      TextSpan(text: "0917 854 9191\n"),
                    ]
                ),
              ),
            ),
            Text("In Touch Community Services",
              style: Theme.of(context).textTheme.subhead.copyWith(color: MyBlue.light),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: SelectableText.rich(
                TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: "+632 893 7603\n"),
                      TextSpan(text: "0917 800 1123\n"),
                      TextSpan(text: "0922 893 8944\n"),
                    ]
                ),
              ),
            ),
            Text("Living Free Foundation",
              style: Theme.of(context).textTheme.subhead.copyWith(color: MyBlue.light),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: SelectableText.rich(
                TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: "0917 322 7087\n"),
                    ]
                ),
              ),
            ),
            Text("Mood Harmony",
              style: Theme.of(context).textTheme.subhead.copyWith(color: MyBlue.light),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: SelectableText.rich(
                TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: "(02) 844-2941\n"),
                    ]
                ),
              ),
            ),
            Text("Dial-a-Friend",
              style: Theme.of(context).textTheme.subhead.copyWith(color: MyBlue.light),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: SelectableText.rich(
                TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: "(02) 525 1743\n"),
                      TextSpan(text: "(02) 525 1881\n"),
                    ]
                ),
              ),
            ),
            Text("UGAT Foundation",
              style: Theme.of(context).textTheme.subhead.copyWith(color: MyBlue.light),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: SelectableText.rich(
                TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: "(02) 426 5992\n"),
                      TextSpan(text: "(02) 426 6001 loc. 4872-73\n"),
                    ]
                ),
              ),
            ),
            Text("700 Club Asia",
              style: Theme.of(context).textTheme.subhead.copyWith(color: MyBlue.light),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: SelectableText.rich(
                TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: "(02) 737 0700\n"),
                    ]
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}