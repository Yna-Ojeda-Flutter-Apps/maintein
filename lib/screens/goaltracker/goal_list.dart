import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:eit_app/utils/const_list_and_enum.dart';
import 'package:eit_app/widgets/bottomnavbar.dart';
import 'package:eit_app/widgets/custom_checkbox_tile.dart';
import 'package:eit_app/themes/apptheme.dart';
import 'package:eit_app/utils/list_filters.dart';
import 'package:eit_app/utils/notification_helper.dart';
import 'package:eit_app/utils/project_db.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
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
  DateFilter _currentDateFilter = DateFilter.All;
  TextEditingController taskController = TextEditingController();
  DateTime newTaskDate;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          elevation: 5.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.0))),
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: EdgeInsets.zero,
            centerTitle: true,
            title: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  child: Text("Task List", style: Theme.of(context).textTheme.title.copyWith(color: MyBlue.light),),
                  onPressed: () => null,
                )
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 20, right: 10, left: 10, bottom: 10),
        child: CustomScrollView(
          slivers: <Widget>[
            _buildDateFilterButton(),
            _buildTaskList(context),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
      floatingActionButton: _addEntryButton(),
    );
  }
  FloatingActionButton _addEntryButton() {
    return FloatingActionButton(
      foregroundColor: Colors.white,
      backgroundColor: MyBlue.picton,
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
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
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
                  icon: Icon(Icons.calendar_today, color: MyBlue.picton,),
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
                  textColor: MyBlue.picton,
                  disabledTextColor: Colors.grey,
                  splashColor: MyBlue.seagull,
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

  SliverList _buildDateFilterButton() {
    return SliverList(delegate: SliverChildListDelegate([SizedBox(
      width: double.infinity,
      child: FlatButton(
        color: MyBlue.picton,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: Text(
          dateFilterToString(_currentDateFilter),
          style: Theme.of(context).textTheme.subhead.copyWith(color: Colors.white),
          textAlign: TextAlign.justify,
        ),
        onPressed: () => _showFilterOptions(context),
      ),
    )]));
  }
  void _showFilterOptions(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
            title: Text("Show entries from:"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _createFilterItem(DateFilter.Today),
                _createFilterItem(DateFilter.All),
                _createFilterItem(DateFilter.Month),
                _createFilterItem(DateFilter.Week),
                _createFilterItem(DateFilter.Null),
              ],
            ),
          );
        }
    );
  }
  RadioListTile _createFilterItem(DateFilter filter) {
    return RadioListTile<DateFilter>(
      title: Text(dateFilterToString(filter)),
      value: filter,
      groupValue: _currentDateFilter,
      onChanged: (DateFilter value) {
        setState(() {
          _currentDateFilter = value;
        });
        Navigator.of(context).pop();
      },
    );
  }

  StreamBuilder<List<Goal>> _buildTaskList(BuildContext context) {
    final dao = Provider.of<GoalDao>(context);
    return StreamBuilder(
      stream: dao.watchAllEntries(),
      builder: (context, AsyncSnapshot<List<Goal>> snapshot) {
        final tasks = snapshot.data ?? List();
        final _filteredOnGoingTasks = filterOnGoingGoals(tasks, _currentDateFilter);
        final _filteredCompletedTasks = filterCompletedGoals(tasks, _currentDateFilter);
        return SliverPadding(
          padding: EdgeInsets.only(right: 10, left: 10, bottom: 10),
          sliver: SliverList(delegate: SliverChildListDelegate(_getTaskListChildren(dao, _filteredOnGoingTasks, _filteredCompletedTasks)),),
        );
      },
    );
  }

  List<dynamic> _getTaskListChildren(GoalDao dao, List<Goal> onGoingGoals, List<Goal> completedGoals) {
    bool _noFilteredTasks = ( onGoingGoals.length < 1 ) && (completedGoals.length < 1);
    bool _allTasksCompleted = ( onGoingGoals.length < 1 ) && (completedGoals.length >= 1);
    List<Widget> taskListChildren = [];
    List<Widget> completedListChildren = [];
    if ( _noFilteredTasks ) {
      taskListChildren.add(Image(
        image: AssetImage('lib/assets/images/data/goals.png'),
        height: 300,
      ));
      taskListChildren.add(Text("Got any goals? Let's plan it the smart way.", style: Theme.of(context).textTheme.subhead.copyWith(color: Colors.grey[600]), textAlign: TextAlign.center));
    } else if ( _allTasksCompleted ) {
      taskListChildren.add(Image(
        image: AssetImage('lib/assets/images/data/completed.png',),
        height: 300,
      ));
      taskListChildren.add(Text("Excellent work! You've finished all tasks.", style: Theme.of(context).textTheme.subhead.copyWith(color: Colors.grey[600]), textAlign: TextAlign.center));
      completedGoals.forEach((item) {
        completedListChildren.add(
            GoalCheckboxListTile(
              dao: dao,
              title: Text(item.task),
              subtitle: Text( (item.dueDate != null) ? DateFormat("E, MMM d h:m a").format(item.dueDate) : 'No deadline set'),
              item: item,
            )
        );
      });
      taskListChildren.add(Padding(padding: EdgeInsets.only(top: 20.0), child: ExpansionTile(
        title: Text("Completed Tasks", style: Theme.of(context).textTheme.display1.copyWith(color: Colors.grey),),
        children: completedListChildren,
      ),));
    } else {
      onGoingGoals.forEach((item) {
        taskListChildren.add(
            GoalCheckboxListTile(
              dao: dao,
              title: Text(item.task),
              subtitle: Text( (item.dueDate != null) ? DateFormat("E, MMM d h:m a").format(item.dueDate) : 'No deadline set'),
              item: item,
            )
        );
      });
      if ( completedGoals.length > 0 ) {
        completedGoals.forEach((item) {
          completedListChildren.add(
              GoalCheckboxListTile(
                dao: dao,
                title: Text(item.task),
                subtitle: Text( (item.dueDate != null) ? DateFormat("E, MMM d h:m a").format(item.dueDate) : 'No deadline set'),
                item: item,
              )
          );
        });
        taskListChildren.add(Padding(padding: EdgeInsets.only(top: 20.0), child: ExpansionTile(
          title: Text("Completed Tasks", style: Theme.of(context).textTheme.display1.copyWith(color: Colors.grey),),
          children: completedListChildren,
        ),));
      }

    }
    return taskListChildren;
  }

}




