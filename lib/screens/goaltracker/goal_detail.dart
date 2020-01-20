import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:eit_app/screens/goaltracker/goal_list.dart';
import 'package:eit_app/screens/widgets/bottomnavbar.dart';
import 'package:eit_app/utils/notification_helper.dart';
//import 'package:eit_app/screens/widgets/screen_arguments.dart';
import 'package:eit_app/utils/project_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
  TextEditingController _subTaskController = TextEditingController();
  TextEditingController _outputController = TextEditingController();
  DateTime _dueDate;
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    final _idArg = ModalRoute.of(context).settings.arguments;
//    final daoGaol = Provider.of<GoalDao>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.grey,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushNamed(context, GoalList.routeName),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              Navigator.pushNamed(context, GoalList.routeName);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 40, right: 40, bottom: 10),
        child: _buildGoalForm(context, _idArg),
      ),
      bottomNavigationBar: bottomNavBar(context),
    );
  }

  StreamBuilder<SmartGoal> _buildGoalForm(BuildContext context, int id) {
    final daoGaol = Provider.of<GoalDao>(context);
    final daoSubTask = Provider.of<SubTaskDao>(context);
    final daoOutput = Provider.of<OutputDao>(context);
    return StreamBuilder(
      stream: daoGaol.watchGoal(id),
      builder: (context, AsyncSnapshot<SmartGoal> snapshot) {
        final smartGoal = snapshot.data ?? SmartGoal();
        if ( !snapshot.hasData ){
          return Center(child: Text("No data yet"),);
        }
        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildTaskField(daoGaol, smartGoal.goal),
              _buildUrgencyField(daoGaol, smartGoal.goal),
              _buildDatePicker(daoGaol, smartGoal.goal),
              _buildAddOutputField(daoOutput, smartGoal.goal.id),
              _buildOutputList(daoOutput, smartGoal.output),
              _buildAddSubTaskField(daoSubTask, smartGoal.goal.id),
              _buildSubTaskList(daoSubTask, smartGoal.subTask),
            ],
          ),
        );
      },
    );
  }
  Padding _buildTaskField(GoalDao daoGoal, Goal goal) {
    return Padding(
      padding: EdgeInsets.only(bottom: 0),
      child: TextFormField(
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter some text';
          } else {
            return null;
          }
        },
        style: TextStyle(
            fontFamily: 'Raleway',
            fontSize: 30,
            fontWeight: FontWeight.w500,
            color: Colors.blue[700]
        ),
        initialValue: goal.task,
        maxLines: null,
        decoration: InputDecoration(
          hintText: 'Edit Task',
          hintStyle: TextStyle(fontSize: 20),
          border: InputBorder.none,
        ),
        onChanged: (value) => daoGoal.updateGoal(goal.copyWith(task: value)),
      ),
    );
  }
  Padding _buildUrgencyField(GoalDao daoGoal, Goal goal) {
    _urgencyLevelController.text = goal.urgency.toString() ?? '1';
    return Padding(
      padding: EdgeInsets.only(bottom: 10, left: 10),
      child: Row(
        children: <Widget>[
          Text('Urgency: ', style: TextStyle(fontSize: 20),),
          Container(
            width: 25.0,
            child: TextFormField(
              validator: (value) {
                int urgency = int.parse(value);
                if ( (urgency > 10) || (urgency < 1) ){
                  return '1 to 10 only.';
                } else {
                  return null;
                }
              },
              controller: _urgencyLevelController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: '?',
                border: InputBorder.none,
              ),
              style: TextStyle(fontSize: 20),
              onChanged: (value) {
                int _urgency = int.parse(value);
                if ( (_urgency > 10) || (_urgency < 1) ){
                  setState(() {
                    _urgencyLevelController.text = goal.urgency.toString();
                  });
                } else {
                  setState(() {
                    _urgencyLevelController.text = value;
                  });
                  daoGoal.updateGoal(goal.copyWith(urgency: int.parse(value)));
                }
              },
            ),
          ),
          Flexible(
            flex: 1,
            child: Slider(
              activeColor: Color(0xff21BEDE),
              min: 1.0,
              max: 10.0,
              value: double.parse(_urgencyLevelController.text),
              onChanged: (value) {
                setState(() {
                  _urgencyLevelController.text = value.toString();
                });
                daoGoal.updateGoal(goal.copyWith(urgency: value.round()));
              },
            ),
          )
        ],
      ),
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
              textColor: Colors.grey,
              child: Text('Add deadline', style: TextStyle(fontSize: 18),),
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
                    Goal tempGaol = Goal(id: goal.id, urgency: goal.urgency, task: goal.task, completed: goal.completed, dueDate: null);
                    await daoGoal.updateGoal(tempGaol);
                    widget.notifications.cancelGoalDueDate(goal.id);
                  },
                ),),
                Expanded(
                  flex: 1,
                  child: OutlineButton(
                    textColor: Colors.grey[700],
                    child: Text(DateFormat("E, MMM d HH:MM a").format(_dueDate), style: TextStyle(fontSize: 18),),
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildAddSubTaskField(SubTaskDao dao, int goalId) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Subtasks', style: TextStyle(fontFamily: 'Raleway', fontSize: 24, color: Colors.grey[600]),),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 20,),
                width: 60,
                child: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    if ( _subTaskController.text.isNotEmpty ) {
                      final subTask = SubTasksCompanion(
                        id: moorPackage.Value(goalId),
                        task: moorPackage.Value(_subTaskController.text),
                      );
                      dao.insertSubTask(subTask);
                      setState(() {
                        _subTaskController.clear();
                      });
                    }
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    } else {
                      return null;
                    }
                  },
                  controller: _subTaskController,
                  decoration: InputDecoration(
                    hintText: 'Add subtasks',
                    border: InputBorder.none,
                  ),
                  style: TextStyle(fontSize: 20),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
  ListView _buildSubTaskList(SubTaskDao dao, List<SubTask> tasks) {
    tasks = cleanSubTaskList(tasks);
    return ListView.builder(
      itemCount: tasks.length,
      shrinkWrap: true,
      itemBuilder: (_, index){
        final item = tasks[index];
        return _buildSubTaskItem(item, dao);
    });
  }
  Widget _buildSubTaskItem(SubTask item, SubTaskDao dao) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => dao.deleteSubTask(item),
        )
      ],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20),
            child: Checkbox(
              value: item.completed,
              onChanged: (value) => dao.deleteSubTask(item)
            ),
          ),
          Expanded(
            child: Text(
              item.task,
              style: TextStyle(fontSize: 18),
            ),
          )

        ],
      ),
    );
  }

  Padding _buildAddOutputField(OutputDao dao, int goalId) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Task Outputs', style: TextStyle(fontFamily: 'Raleway', fontSize: 24, color: Colors.grey[600]),),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 20,),
                width: 60,
                child: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    if ( _outputController.text.isNotEmpty ) {
                      final output = OutputsCompanion(
                        id: moorPackage.Value(goalId),
                        item: moorPackage.Value(_outputController.text),
                      );
                      dao.insertOutput(output);
                      setState(() {
                        _outputController.clear();
                      });
                    }
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    } else {
                      return null;
                    }
                  },
                  controller: _outputController,
                  decoration: InputDecoration(
                    hintText: 'Add task outputs',
                    border: InputBorder.none,
                  ),
                  style: TextStyle(fontSize: 20),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
  ListView _buildOutputList(OutputDao dao, List<Output> outputs) {
    outputs = cleanOutputList(outputs);
    return ListView.builder(
        itemCount: outputs.length,
        shrinkWrap: true,
        itemBuilder: (_, index){
          final item = outputs[index];
          return _buildOutputItem(item, dao);
        });
  }
  Widget _buildOutputItem(Output item, OutputDao dao) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => dao.deleteOutput(item),
        )
      ],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20),
            child: Checkbox(
                value: item.completed,
                onChanged: (value) => dao.deleteOutput(item)
            ),
          ),
          Expanded(
            child: Text(
              item.item,
              style: TextStyle(fontSize: 18),
            ),
          )

        ],
      ),
    );
  }
}

List<SubTask> cleanSubTaskList(List<SubTask> tasks) {
  for ( var ctr = 0; ctr <  tasks.length; ctr++ ) {
    if ( tasks[ctr] == null ) {
      tasks.remove(tasks[ctr]);
    }
  }
  return tasks;
}
List<Output> cleanOutputList(List<Output> outputs) {
  for ( var ctr = 0; ctr <  outputs.length; ctr++ ) {
    if ( outputs[ctr] == null ) {
      outputs.remove(outputs[ctr]);
    }
  }
  return outputs;
}