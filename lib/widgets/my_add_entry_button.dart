import 'package:eit_app/themes/apptheme.dart';
import 'package:flutter/material.dart';

class AddEntryButton extends StatelessWidget {
  final Function onPressed;

  AddEntryButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: MyBlue.picton,
      foregroundColor: Colors.white,
      onPressed: onPressed,
      tooltip: "Add Entry",
      child: Icon(Icons.add),
    );
  }

}
