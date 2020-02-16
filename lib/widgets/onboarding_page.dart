import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:maintein/themes/apptheme.dart';


class OnBoardingPage extends StatefulWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final List<String> list;
  final Function onNext;

  OnBoardingPage({this.title, this.imagePath, this.subtitle, this.list, this.onNext});
  @override
  State<StatefulWidget> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage>{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: <Widget>[
          ( widget.imagePath.length > 0 ) ? Image(
            image: AssetImage(widget.imagePath),
            height: 250,
          ) : Container(),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              widget.title,
              style: Theme.of(context).textTheme.display2.copyWith(color: MyBlue.light),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              widget.subtitle ?? "",
              style: Theme.of(context).textTheme.body1.copyWith(fontSize: 18, height: 1.5, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}