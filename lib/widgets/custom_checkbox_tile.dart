import 'package:maintein/screens/goaltracker/goal_detail.dart';
import 'package:maintein/themes/apptheme.dart';
import 'package:maintein/utils/project_db.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class GoalCheckboxListTile extends StatefulWidget {
  final Widget title;
  final Widget subtitle;
  final GoalDao dao;
  final Goal item;

  GoalCheckboxListTile({
    this.title,
    this.subtitle,
    this.dao,
    this.item
  });
  @override
  State<StatefulWidget> createState() => _GoalCheckboxListTileState();

}

class _GoalCheckboxListTileState extends State<GoalCheckboxListTile>{
  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          icon: Icons.delete,
          foregroundColor: Colors.redAccent,
          onTap: () => _confirmDelete(context, widget.item, widget.dao),
        )
      ],
      child: Padding(
        padding: EdgeInsets.only(right: 10, left: 10),
        child: Row(
          children: <Widget>[
            Checkbox(
              activeColor: MyBlue.light,
              value: widget.item.completed,
              onChanged: (bool newValue) async {
                await widget.dao.updateGoal(widget.item.copyWith(completed: newValue));
                if ( newValue ) {
                  _taskCompletedSnackBar();
                }
              },
            ),
            Expanded(
              child: ListTile(
                title: widget.title,
                subtitle: widget.subtitle,
                onTap: () => Navigator.pushNamed(
                  context,
                  GoalDetail.routeName,
                  arguments: widget.item.id,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, Goal goal, GoalDao dao) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: Text("Delete '"+goal.task+"'?"),
          content: Text("Deleting this entry cannot be undone."),
          actions: <Widget>[
            FlatButton(child: Text('Cancel'), onPressed: () => Navigator.of(context).pop(),),
            FlatButton(
              child: Text('Delete', style: TextStyle(color: Colors.redAccent),),
              onPressed: () async {
                dao.deleteGoal(goal);
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }

  void _taskCompletedSnackBar(){
    Flushbar(
      message: "Nice! A task was completed",
      icon: Icon(Icons.done, size: 20.0, color: Colors.white,),
      duration: Duration(seconds: 3),
      borderRadius: 10.0,
      margin: EdgeInsets.only(bottom: 100.0, left: 10, right: 10),
      backgroundColor: Colors.blueGrey,
    )..show(context);
  }
}

class SubTaskCheckboxListTile extends StatefulWidget {
  final SubTaskDao dao;
  final SubTask item;

  SubTaskCheckboxListTile({
    this.dao,
    this.item
  });
  @override
  State<StatefulWidget> createState() => _SubTaskCheckboxListTileState();

}

class _SubTaskCheckboxListTileState extends State<SubTaskCheckboxListTile>{
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10, left: 10),
      child: Row(
        children: <Widget>[
          Checkbox(
            activeColor: MyBlue.light,
            value: widget.item.completed,
            onChanged: (bool newValue) async => await widget.dao.updateSubTask(widget.item.copyWith(completed: newValue)),
          ),
          Expanded(
            flex: 1,
            child: TextFormField(
              style: Theme.of(context).textTheme.body1,
              initialValue: widget.item.task,
              onChanged: (value) async => await widget.dao.updateSubTask(widget.item.copyWith(task: value)),
              maxLines: null,
              decoration: InputDecoration(
                hintText: "Add expected task outcome",
                hintStyle: Theme.of(context).textTheme.body1.copyWith(color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.clear, size: 20.0, color: Colors.grey,),
            onPressed: () async => await widget.dao.deleteSubTask(widget.item),
          ),
        ],
      ),
    );
  }


}

class OutputCheckboxListTile extends StatefulWidget {
  final OutputDao dao;
  final Output item;

  OutputCheckboxListTile({
    this.dao,
    this.item
  });
  @override
  State<StatefulWidget> createState() => _OutputCheckboxListTileState();

}

class _OutputCheckboxListTileState extends State<OutputCheckboxListTile>{
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10, left: 10),
      child: Row(
        children: <Widget>[
          Checkbox(
            activeColor: MyBlue.light,
            value: widget.item.completed,
            onChanged: (bool newValue) async => await widget.dao.updateOutput(widget.item.copyWith(completed: newValue)),
          ),
          Expanded(
            flex: 1,
            child: TextFormField(
              style: Theme.of(context).textTheme.body1,
              initialValue: widget.item.item,
              onChanged: (value) async => await widget.dao.updateOutput(widget.item.copyWith(item: value)),
              maxLines: null,
              decoration: InputDecoration(
                hintText: "Add expected task outcome",
                hintStyle: Theme.of(context).textTheme.body1.copyWith(color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.clear, size: 20.0, color: Colors.grey,),
            onPressed: () async => await widget.dao.deleteOutput(widget.item),
          ),
        ],
      ),
    );
  }
}

