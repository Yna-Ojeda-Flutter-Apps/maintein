import 'package:maintein/themes/apptheme.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';


class ActiveListeningForm extends StatefulWidget {
  final String titleInitialValue;
  final String header;
  final List<String> checkListItems;
  final Function titleOnChanged;
  final Function checkboxOnChange;
  final Function textFieldOnChange;
  final bool isCheckboxList;


  ActiveListeningForm({this.titleInitialValue, this.header, this.checkListItems, this.titleOnChanged, this.checkboxOnChange, this.textFieldOnChange,  this.isCheckboxList});
  @override
  State<StatefulWidget> createState() => _ActiveListeningFormState();

}

class _ActiveListeningFormState extends State<ActiveListeningForm>{
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
            (widget.isCheckboxList) ? CheckboxGroup(
              labels: widget.checkListItems ?? List<String>(),
              onChange: widget.checkboxOnChange,
              padding: EdgeInsets.all(10.0),
              itemBuilder: (Checkbox checkbox, Text text, int index) {
                return Row(
                  children: <Widget>[
                    checkbox,
                    Expanded(child: text,)
                  ],
                );
              },
            ) :
            TextFormField(
              style: Theme.of(context).textTheme.body1,
              maxLines: null,
              decoration: InputDecoration(
                hintText: "Summary of what you've learned from listening",
                hintStyle: Theme.of(context).textTheme.body1.copyWith(color: Colors.grey),
                hintMaxLines: 3,
                border: InputBorder.none,
              ),
              onChanged: widget.textFieldOnChange,
            )
          ]),)
        ],
      ),
    );
  }
}