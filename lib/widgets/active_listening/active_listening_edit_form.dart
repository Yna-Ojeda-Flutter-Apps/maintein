import 'package:eit_app/themes/apptheme.dart';
import 'package:eit_app/utils/project_db.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:provider/provider.dart';


class ActiveListeningEditForm extends StatefulWidget {
  final int id;
  final String header;
  final bool isCheckboxList;
  final List<String> labels;
  final List<int> characteristicIndices;

  ActiveListeningEditForm({this.id, this.header, this.isCheckboxList, this.labels, this.characteristicIndices});
  @override
  State<StatefulWidget> createState() => _ActiveListeningEditFormState();

}

class _ActiveListeningEditFormState extends State<ActiveListeningEditForm>{
  @override
  Widget build(BuildContext context) {
    ListenDao dao = Provider.of<ListenDao>(context);
    return StreamBuilder(
      stream:  dao.watchListenEntry(widget.id),
      builder: (context, AsyncSnapshot<ListenRecord> snapshot) {
        if ( !snapshot.hasData ){
          return Image(
            image: AssetImage('lib/assets/images/data/loading.png'),
            height: 300,
          );
        }
        final ListenRecord record = snapshot.data ?? ListenRecord();
        List<Desc> characteristics = record.desc ?? List<Desc>();
        characteristics.removeWhere((characteristic) => characteristic == null);
        List<String> checked = [];
        int _counter = 0;
        (widget.characteristicIndices ?? List<int>()).forEach((index) {
          if ( characteristics[index].charVal ) {
            checked.add(widget.labels[_counter]);
          }
          _counter++;
        });
        _counter = 0;
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
                  onChanged: (value) {
                    if ( value.length > 0 ) {
                      dao.updateListenActivity(record.detail.copyWith(actName: value));
                    }
                  },
                  initialValue: record.detail.actName,
                ),
                Text(
                  widget.header,
                  style: Theme.of(context).textTheme.display1.copyWith(color: MyBlue.seagull),
                ),
                ( widget.isCheckboxList ?? false) ? CheckboxGroup(
                  labels: widget.labels,
                  checked: checked,
                  onChange: (bool isChecked, String label, int index) async {
                    await dao.updateDesc(characteristics[widget.characteristicIndices[index]].copyWith(charVal: isChecked));
                    await dao.updateListenActivity(record.detail.copyWith(descriptionCount: characteristics.where((c) => c.charVal == true).length));
                  },
                  padding: EdgeInsets.all(10.0),
                  itemBuilder: (Checkbox checkbox, Text text, int index) {
                    return Row(
                      children: <Widget>[
                        checkbox,
                        Expanded(child: text,)
                      ],
                    );
                  },
                )
                    : TextFormField(
                  style: Theme.of(context).textTheme.body1,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: "Summary of what you've learned from listening",
                    hintStyle: Theme.of(context).textTheme.body1.copyWith(color: Colors.grey),
                    hintMaxLines: 3,
                    border: InputBorder.none,
                  ),
                  initialValue: record.detail.insights,
                  onChanged: (value) {
                    if ( value.length > 0 ) {
                      dao.updateListenActivity(record.detail.copyWith(actName: value));
                    }
                  },
                ),
              ]),)
            ],
          ),
        );
      },
    );
  }

}