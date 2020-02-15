import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:maintein/widgets/bottomnavbar.dart';
import 'package:maintein/widgets/custom_checkbox_tile.dart';
import 'package:maintein/themes/apptheme.dart';
import 'package:maintein/utils/notification_helper.dart';
import 'package:maintein/utils/project_db.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:moor/moor.dart' as moorPackage;

class GoalDetail extends StatefulWidget {
  static const routeName = '/goal_detail';
  final NotificationManager notifications;
  GoalDetail(this.notifications);

  @override
  State<StatefulWidget> createState() {
    return GoalDetailState();
  }
}

class GoalDetailState extends State<GoalDetail> {
  TextEditingController _urgencyLevelController = TextEditingController();
  TextEditingController _newOutputController = TextEditingController();
  TextEditingController _newSubTaskController = TextEditingController();

  DateTime _dueDate;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
      floatingActionButton: _buildMarkCompleteButton(context, args),
      body: Padding(
        padding: EdgeInsets.only(right: 10, left: 10, bottom: 10),
        child: CustomScrollView(
          slivers: <Widget>[
            _buildGoalForm(context, args),
          ],
        ),
      ),
    );
  }

  StreamBuilder<SmartGoal> _buildMarkCompleteButton(BuildContext context, int id) {
    final daoGoal = Provider.of<GoalDao>(context);
    return StreamBuilder(
      stream: daoGoal.watchGoal(id),
      builder: (context, AsyncSnapshot<SmartGoal> snapshot) {
        if (!snapshot.hasData) {
          return FloatingActionButton(child: Text("..."), backgroundColor: Colors.grey, foregroundColor: Colors.white, onPressed: () => null,);
        }
        final smartGoal = snapshot.data ?? SmartGoal();
        final _goal = smartGoal.goal;
        final _isCompleted = _goal.completed;
        return FloatingActionButton(
          backgroundColor: (_isCompleted) ? MyBlue.picton : Colors.grey,
          foregroundColor: Colors.white,
          onPressed: () async {
            await daoGoal.updateGoal(_goal.copyWith(completed: !_isCompleted));
            if ( !_isCompleted ) {
              _taskCompletedSnackBar();
            }
          },
          tooltip: (_isCompleted) ? "Unmark Completed" : "Mark Complete",
          child: Icon(Icons.done_all),
        );
      },
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


  List<dynamic> _getFormChildren(GoalDao daoGoal, SubTaskDao daoSubTask, OutputDao daoOutput, SmartGoal smartGoal) {
    final Goal _goal = smartGoal.goal;
    smartGoal.subTask.removeWhere((task) => task == null);
    smartGoal.output.removeWhere((task) => task == null);
    final _subTasks = smartGoal.subTask ?? List<SubTask>();
    final _outputs = smartGoal.output ?? List<Output>();
    List<Widget> formChildren = [];
    
    formChildren.add(_buildTaskField(daoGoal, _goal));
    formChildren.add(_buildUrgencyField(daoGoal, _goal));
    formChildren.add(_buildDatePicker(daoGoal, _goal));
    formChildren.add(Text("Expected Outputs", style: Theme.of(context).textTheme.subhead,));
    if ( _outputs.length > 0 ) {
      _outputs.forEach((item) => formChildren.add(OutputCheckboxListTile(
        item: item,
        dao: daoOutput,
      )));
    }
    formChildren.add(_addOutput(daoOutput, _goal.id));
    formChildren.add(Text("Subtasks", style: Theme.of(context).textTheme.subhead,));
    if ( _subTasks.length > 0 ) {
      _subTasks.forEach((task) => formChildren.add(SubTaskCheckboxListTile(
        item: task,
        dao: daoSubTask,
      )));
    }
    formChildren.add(_addSubTask(daoSubTask, _goal.id));

    return formChildren;
  }
  StreamBuilder<SmartGoal> _buildGoalForm(BuildContext context, int id) {
    final daoSubTask = Provider.of<SubTaskDao>(context);
    final daoOutput = Provider.of<OutputDao>(context);
    final daoGoal = Provider.of<GoalDao>(context);
      return StreamBuilder(
        stream: daoGoal.watchGoal(id),
        builder: (context, AsyncSnapshot<SmartGoal> snapshot) {
          if (!snapshot.hasData) {
            return SliverList(delegate: SliverChildListDelegate([Center(child: Text("no data yet"),)]),);
          }
          final smartGoal = snapshot.data ?? SmartGoal();
          return SliverList(
            delegate: SliverChildListDelegate(_getFormChildren(daoGoal, daoSubTask, daoOutput, smartGoal)),
          );
        },
      );
    }
  TextFormField _buildTaskField(GoalDao dao, Goal goal) {
    return TextFormField(
      validator: (value) {
        if ( value.isEmpty ) {
          return 'Please enter some text';
        } else {
          return null;
        }
      },
      style: Theme.of(context).textTheme.display1.copyWith(color: MyBlue.light),
      initialValue: goal.task,
      maxLines: null,
      decoration: InputDecoration(
        hintText: "Edit Task Name",
        hintStyle: Theme.of(context).textTheme.display1.copyWith(color: Colors.grey),
        border: InputBorder.none
      ),
      onChanged: (value) => dao.updateGoal(goal.copyWith(task: value)),
    );
  }
  Row _buildUrgencyField(GoalDao dao, Goal goal) {
    _urgencyLevelController.text = goal.urgency.toString() ?? '1';
    return Row(
      children: <Widget>[
        Text('Urgency: ', style: Theme.of(context).textTheme.subhead),
        Container(
          width: 25.0,
          child: TextField(
            controller: _urgencyLevelController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(border: InputBorder.none),
            style: Theme.of(context).textTheme.subhead,
            onChanged: (value) {
              int _urgency = _constrainUrgencyValue(int.parse(value));
              _urgencyLevelController.text = _urgency.toString();
              dao.updateGoal(goal.copyWith(urgency: _urgency));
            },
          ),
        ),
        Flexible(
          flex: 1,
          child: Slider(
            activeColor: MyBlue.light,
            min: 1.0,
            max: 10.0,
            value: goal.urgency.toDouble(),
            onChanged: (value) {
              _urgencyLevelController.text = value.round().toString();
              dao.updateGoal(goal.copyWith(urgency: value.round()));
            },
          ),
        ),
      ],
    );
  }
  Padding _buildDatePicker(GoalDao daoGoal, Goal goal) {
    _dueDate = goal.dueDate;
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Row(
        children: <Widget>[
          Container(
              width: 40,
              child: IconButton(
                icon: Icon(Icons.calendar_today),
                onPressed: () async {
                  _dueDate = await showDatePicker(
                      context: context,
                      initialDate: _dueDate ?? DateTime.now(),
                      firstDate: DateTime(DateTime.now().year),
                      lastDate: DateTime(2050)
                  );
                  if ( _dueDate != null ) {
                    final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(_dueDate ?? DateTime.now())
                    );
                    _dueDate = DateTimeField.combine(_dueDate, time);
                  }
                  await daoGoal.updateGoal(goal.copyWith(dueDate: _dueDate));
                  widget.notifications.scheduleGoalDueDate(goal.id, goal.task, "Your task is due.", _dueDate);
                },
              )
          ),
          ( _dueDate == null ) ?
          Expanded(
            flex: 1,
            child: FlatButton(
              textColor: Colors.grey[200],
              child: Text('Add deadline', style: Theme.of(context).textTheme.button,),
              onPressed: () async {
                _dueDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(DateTime.now().year),
                    lastDate: DateTime(2050)
                );
                if ( _dueDate != null ) {
                  final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(DateTime.now())
                  );
                  _dueDate = DateTimeField.combine(_dueDate, time);
                }
                await daoGoal.updateGoal(goal.copyWith(dueDate: _dueDate));
                widget.notifications.scheduleGoalDueDate(goal.id, goal.task, "Your task is due.", _dueDate);

              },
            ),
          ) :
          Expanded(
            flex: 1,
            child: Row(
              children: <Widget>[
                Container(width: 40, child: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () async {
                    setState(() {
                      _dueDate = null;
                    });
                    Goal tempGaol = Goal(id: goal.id, urgency: goal.urgency, task: goal.task, completed: goal.completed, dueDate: null, dateCreated: goal.dateCreated);
                    await daoGoal.updateGoal(tempGaol);
                    widget.notifications.cancelGoalDueDate(goal.id);
                  },
                ),),
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: OutlineButton(
                      textColor: Colors.grey[200],
                      child: Text(DateFormat("E, MMM d HH:MM a").format(_dueDate), style: Theme.of(context).textTheme.button, textAlign: TextAlign.justify,),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      borderSide: BorderSide(color: Colors.grey),
                      onPressed: () async {
                        _dueDate = await showDatePicker(
                            context: context,
                            initialDate: _dueDate ?? DateTime.now(),
                            firstDate: DateTime(DateTime.now().year),
                            lastDate: DateTime(2050)
                        );
                        if ( _dueDate != null ) {
                          final time = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.fromDateTime(_dueDate ?? DateTime.now())
                          );
                          _dueDate = DateTimeField.combine(_dueDate, time);
                        }
                        await daoGoal.updateGoal(goal.copyWith(dueDate: _dueDate));
                        widget.notifications.scheduleGoalDueDate(goal.id, goal.task, "Your task is due.", _dueDate);
                      },
                    ),
                  )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  _addOutput(OutputDao dao, int goalId) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.add, size: 20.0,),
          onPressed: () async {
            final output = OutputsCompanion(
              item: moorPackage.Value(_newOutputController.text),
              id: moorPackage.Value(goalId),
              dateCreated: moorPackage.Value(DateTime.now()),
            );
            await dao.insertOutput(output);
            _newOutputController.clear();
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: TextField(
              controller: _newOutputController,
              style: Theme.of(context).textTheme.body1,
              maxLines: null,
              decoration: InputDecoration(
                hintText: "Add expected outcomes",
                hintStyle: Theme.of(context).textTheme.body1.copyWith(color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
  _addSubTask(SubTaskDao dao, int goalId) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.add, size: 20.0,),
          onPressed: () async {
            final subTask = SubTasksCompanion(
              task: moorPackage.Value(_newSubTaskController.text),
              id: moorPackage.Value(goalId),
              dateCreated: moorPackage.Value(DateTime.now()),
            );
            await dao.insertSubTask(subTask);
            _newSubTaskController.clear();
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: TextField(
              controller: _newSubTaskController,
              style: Theme.of(context).textTheme.body1,
              maxLines: null,
              decoration: InputDecoration(
                hintText: "Add subtasks",
                hintStyle: Theme.of(context).textTheme.body1.copyWith(color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );
  }



}

int _constrainUrgencyValue(int x) {
  if ( x > 10 ) {
    return 10;
  } if ( x < 1 ) {
    return 1;
  } else {
    return x;
  }
}

