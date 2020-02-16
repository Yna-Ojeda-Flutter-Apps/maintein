import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:maintein/utils/project_db.dart';
import 'package:provider/provider.dart';

class MySlidable extends StatefulWidget {
  final String entryName;
  final int entryType;
  final entry;
  final Widget child;

  MySlidable({this.entryName, this.entryType, this.child, this.entry});

  @override
  State<StatefulWidget> createState() => _MySlidableState();

}

class _MySlidableState extends State<MySlidable>{
  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          icon: Icons.delete,
          foregroundColor: Colors.red,
          onTap: () => _confirmDelete(),
        )
      ],
      child: widget.child,
    );
  }
  void _confirmDelete() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          final daoOfJouranl = Provider.of<JournalDao>(context);
          final daoOfListen = Provider.of<ListenDao>(context);
          final daoOfAssessment = Provider.of<AssessmentDao>(context);
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
            title: Text("Delete '"+widget.entryName+"'?"),
            content: Text("Deleting this entry cannot be undone."),
            actions: <Widget>[
              FlatButton(child: Text('Cancel'), onPressed: () => Navigator.of(context).pop(),),
              FlatButton(
                child: Text('Delete', style: TextStyle(color: Colors.redAccent),),
                onPressed: () async {
                  if ( widget.entryType == 0 ) {
                    await daoOfAssessment.deleteAssessment(widget.entry);
                  } else if ( widget.entryType == 1 ){
                    await daoOfJouranl.deleteJournalEntry(widget.entry);
                  } else {
                    await daoOfListen.deleteListenActivity(widget.entry);
                  }
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }
    );
  }
}