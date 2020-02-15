import 'package:flutter/material.dart';

class HomeGreeting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 70.0, bottom: 0.0, right: 10, left: 10),
          child: Text(
            'Hello, there.',
            style: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 30,
                color: Colors.white
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 0.0, bottom: 0.0, right: 20, left: 20),
          child: Text(
            'What do you wish to do?',
            style: Theme.of(context).textTheme.title.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

}