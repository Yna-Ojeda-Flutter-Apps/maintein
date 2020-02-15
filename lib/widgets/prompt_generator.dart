import 'package:maintein/themes/apptheme.dart';
import 'package:flutter/material.dart';
import "dart:math";

import 'package:shared_preferences/shared_preferences.dart';

final _random = new Random();
_randomElement(List lst) => lst[_random.nextInt(lst.length)];

class PromptGenerator extends StatefulWidget {
  final List<String> prompts;
  final String header;
  final String promptType;

  PromptGenerator(this.prompts, this.header, this.promptType);

  @override
  State<StatefulWidget> createState() {
    return _PromptGeneratorState();
  }
}

class _PromptGeneratorState extends State<PromptGenerator> {
  String _prompt;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        child: Text(
          'Prompts',
          style: TextStyle(color: Colors.white),
        ),
        color: MyBlue.picton,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
        elevation: 5.0,
        onPressed: () async {
          _prompt = _randomElement(widget.prompts) ?? "";
          SharedPreferences prefs = await SharedPreferences.getInstance();
          int _accessCount = prefs.getInt(widget.promptType) ?? 0;
          await prefs.setInt(widget.promptType, _accessCount+1);
          _generatePromptDialog();
        },
      ),
    );
  }
  Future<Null> _generatePromptDialog() async {
    return showDialog <Null>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: Text(widget.header),
          content: Text(_prompt),
          actions: <Widget>[
            FlatButton(
              child: Text('Next Prompt'),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                int _accessCount = prefs.getInt(widget.promptType) ?? 0;
                await prefs.setInt(widget.promptType, _accessCount+1);
                setState(() {
                  _prompt = _randomElement(widget.prompts);
                  Navigator.of(context).pop();
                  _generatePromptDialog();
                });
              },
            )
          ],
        );
      }
    );
  }

}