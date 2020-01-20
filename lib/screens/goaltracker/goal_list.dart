import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:eit_app/screens/goaltracker/goal_detail.dart';
import 'package:eit_app/screens/widgets/bottomnavbar.dart';
import 'package:eit_app/utils/notification_helper.dart';
import 'package:eit_app/utils/project_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:moor/moor.dart' as moorPackage;
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';


class GoalList extends StatefulWidget {
  static const routeName = '/goal_list';
  final NotificationManager notifications;

  GoalList(this.notifications);


  @override
  State<StatefulWidget> createState() {
    return _GoalListState();
  }
}

class _GoalListState extends State<GoalList> {
  TextEditingController taskController = TextEditingController();
  DateTime newTaskDate;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    resizeToAvoidBottomPadding: false,
      body: Padding(
        padding: EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _headline(),
            Expanded(child: _buildTaskList(context),),
          ],
        ),
      ),
      bottomNavigationBar: bottomNavBar(context),
      floatingActionButton: _addEntryButton(),
    );
  }



  Padding _headline() {
    return Padding(
        padding: EdgeInsets.only(top: 40,),
        child: Text(
          'Tasks',
          style: TextStyle(
              fontFamily: 'Raleway',
              fontSize: 45,
              fontWeight: FontWeight.w500
          ),
        )
    );
  }

  StreamBuilder<List<SmartGoal>> _buildTaskList(BuildContext context) {
    final dao = Provider.of<GoalDao>(context);
    return StreamBuilder(
      stream: dao.watchAllGoals(),
      builder: (context, AsyncSnapshot<List<SmartGoal>> snapshot) {
        final tasks = snapshot.data ?? List();
        return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (_, index) {
              final item = tasks[index];
              return _buildTaskItem(item, dao);
            }
        );
      },
    );
  }
  Widget _buildTaskItem(SmartGoal item, GoalDao dao) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => dao.deleteGoal(item.goal),
        )
      ],
      child: CheckboxListTile(
        title: Text(item.goal.task),
        subtitle: Text( (item.goal.dueDate != null) ? DateFormat("E, MMM d HH:MM a").format(item.goal.dueDate) : 'No deadline set'),
        secondary: IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            Navigator.pushNamed(
              context,
              GoalDetail.routeName,
              arguments: item.goal.id,
            );
          },
        ),
        value: item.goal.completed,
        onChanged: (newValue) => dao.updateGoal(item.goal.copyWith(completed: newValue)),
      ),
    );
  }

  FloatingActionButton _addEntryButton() {
    return FloatingActionButton(
      backgroundColor: Color(0xff21BEDE),
      onPressed: () => _newEntryForm(),
      tooltip: 'Add Goal',
      child: Icon(Icons.add),
    );
  }
  void _newEntryForm() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Form(
            key: _formKey,
            child: AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0),),
              elevation: 0.0,
              title: TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  } else {
                    return null;
                  }
                },
                style: TextStyle(fontSize: 24),
                controller: taskController,
                decoration: InputDecoration(
                  hintText: 'New Task',
                  hintStyle: TextStyle(fontFamily: 'Roboto', fontSize: 20),
                  border: InputBorder.none,
                ),
                maxLines: null,
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.calendar_today, color: Colors.blue,),
                  onPressed: () async {
                    newTaskDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2019),
                        lastDate: DateTime(2050)
                    );
                    if ( newTaskDate != null ) {
                      final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(DateTime.now())
                      );
                      newTaskDate = DateTimeField.combine(newTaskDate, time);
                    }
                  },
                ),
                FlatButton(
                  textColor: Colors.blue,
                  disabledTextColor: Colors.grey,
                  splashColor: Colors.blueAccent,
                  onPressed: () async {
                    if ( _formKey.currentState.validate() ){
                      final dao = Provider.of<GoalDao>(context);
                      final goal = GoalsCompanion(
                          task: moorPackage.Value(taskController.text),
                          urgency: moorPackage.Value(1),
                          dueDate: moorPackage.Value(newTaskDate)
                      );
                      int id = await dao.insertGoal(goal);
                      if ( newTaskDate != null ){
                        widget.notifications.scheduleGoalDueDate(id, taskController.text, "Your task is due.", newTaskDate);
                      }
                      setState(() {
                        newTaskDate = null;
                        taskController.clear();
                      });
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text('Save', style: TextStyle(fontSize: 16),),
                )

              ],
            ),
          );
        }
    );


  }
}




