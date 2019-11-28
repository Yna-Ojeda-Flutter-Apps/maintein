import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:eit_app/screens/widgets/bottomnavbar.dart';
import 'package:eit_app/screens/widgets/screen_arguments.dart';
import 'package:eit_app/utils/project_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class GoalDetail extends StatefulWidget {
  static const routeName = '/goal_detail';

  GoalDetail();
  @override
  State<StatefulWidget> createState() {
    return GoalDetailState();
  }
}


class GoalDetailState extends State<GoalDetail> {
  GoalDetailState();

  final _formKey = GlobalKey<FormState>();

  TextEditingController goalTitleController = TextEditingController();
  TextEditingController goalUrgencyController = TextEditingController();
  DateTime dueDate;

  @override
  Widget build(BuildContext context) {
    final UpdateGoalArguments args = ModalRoute.of(context).settings.arguments;
    final daoGoal = Provider.of<GoalDao>(context);
    goalTitleController.text = args.goal.task;
    goalUrgencyController.text = args.goal.urgency.toString();
    dueDate = args.goal.dueDate;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,),
          onPressed: () => Navigator.pushNamed(context, '/goal_list'),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              daoGoal.deleteGoal(args.goal);
              Navigator.pushNamed(context, '/goal_list');
            },
          )
        ],
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
            color: Colors.grey
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 50, right: 50, bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            goalForm(),
          ],
        ),
      ),

      bottomNavigationBar: bottomNavBar(),
    );
  }


  Form goalForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildTaskField(),
          _buildUrgencyField(),
          _buildDatePicker(),
        ],
      ),
    );
  }
  Padding _buildTaskField() {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
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
        controller: goalTitleController,
        maxLines: null,
        decoration: InputDecoration(
          hintText: 'Edit Task',
          hintStyle: TextStyle(fontSize: 20),
          border: InputBorder.none,
        ),
        onChanged: (value) => goalTitleController.text = value,
      ),
    );
  }
  Padding _buildDatePicker() {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () async {
                dueDate = await showDatePicker(
                    context: context,
                    initialDate: dueDate ?? DateTime.now(),
                    firstDate: DateTime(2019),
                    lastDate: DateTime(2050)
                );
              },
            ),
          ),
          Expanded(
            flex: 11,
            child: ( dueDate == null ) ? FlatButton(
              textColor: Colors.grey,
              child: Text('Add deadline', style: TextStyle(fontSize: 18),),
              onPressed: () async {
                dueDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2019),
                    lastDate: DateTime(2050)
                );
                if ( dueDate != null ) {
                  final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(DateTime.now())
                  );
                  dueDate = DateTimeField.combine(dueDate, time);
                }
              },
            ) :
            OutlineButton(
                textColor: Colors.grey[700],
                child: Text(DateFormat("E, MMM d").format(dueDate), style: TextStyle(fontSize: 18),),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                borderSide: BorderSide(color: Colors.grey),
                onPressed: () async {
                  dueDate = await showDatePicker(
                      context: context,
                      initialDate: dueDate,
                      firstDate: DateTime(2019),
                      lastDate: DateTime(2050)
                  );
                  if ( dueDate != null ) {
                    final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(DateTime.now())
                    );
                    setState(() {
                      dueDate = DateTimeField.combine(dueDate, time);
                    });
                  }
                }
            ),
          ),

        ],
      ),
    );
  }
  Padding _buildUrgencyField() {
    return Padding(
      padding: EdgeInsets.only(bottom: 10, left: 10),
      child: Row(
        children: <Widget>[
          Text('Urgency Level: ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          Container(width: 50, child: TextFormField(
            validator: (value) {
              int urgency = int.parse(value);
              debugPrint('Urgency: $urgency');
              if ( (urgency > 10) || (urgency < 1) ){
                return '1 to 10 only.';
              } else {
                return null;
              }
            },
            controller: goalUrgencyController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: '?',
              border: InputBorder.none,

            ),
            style: TextStyle(fontSize: 18,),
          ),),
        ],
      ),
    );
  }

}



