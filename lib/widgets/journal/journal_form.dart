import 'package:eit_app/themes/apptheme.dart';
import 'package:flutter/material.dart';

class JournalForm extends StatefulWidget {
  final String titleInitialValue;
  final String textFieldInitialValue;
  final String header;
  final String textFieldHint;
  final Function titleOnChanged;
  final Function textFieldOnChanged;

  JournalForm({
    this.titleInitialValue,
    this.textFieldInitialValue,
    this.header,
    this.textFieldHint,
    this.titleOnChanged,
    this.textFieldOnChanged
  });

  @override
  State<StatefulWidget> createState() => _JournalFormState();

}

class _JournalFormState extends State<JournalForm>{
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(delegate: SliverChildListDelegate([
            TextFormField(
              style: Theme.of(context).textTheme.display1.copyWith(color: MyBlue.light),
              maxLines: null,
              decoration: InputDecoration(
                hintText: 'Enter Activity Name',
                hintStyle: Theme.of(context).textTheme.display1.copyWith(color: Colors.grey),
                border: InputBorder.none,
              ),
              onChanged: widget.titleOnChanged,
              initialValue: widget.titleInitialValue,
            ),
            Text(
              widget.header,
              style: Theme.of(context).textTheme.display1.copyWith(color: MyBlue.seagull),
            ),
            TextFormField(
              style: Theme.of(context).textTheme.body1,
              maxLines: null,
              decoration: InputDecoration(
                hintText: widget.textFieldHint,
                hintStyle: Theme.of(context).textTheme.body1.copyWith(color: Colors.grey),
                hintMaxLines: 10,
                border: InputBorder.none,
              ),
              onChanged: widget.textFieldOnChanged,
              initialValue: widget.textFieldInitialValue,
            ),
          ]),)
        ],
      ),
    );
  }
}