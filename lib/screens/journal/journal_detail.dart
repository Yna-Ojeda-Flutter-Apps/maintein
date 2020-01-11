import 'package:dots_indicator/dots_indicator.dart';
import 'package:eit_app/screens/journal/journal_list.dart';
import 'package:eit_app/screens/widgets/bottomnavbar.dart';
import 'package:eit_app/utils/project_db.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class JournalDetail extends StatefulWidget {
  static const routeName = '/journal_detail';
  @override
  State<StatefulWidget> createState() {
    return _JournalDetailState();
  }
}

class _JournalDetailState extends State<JournalDetail> {
  PageController _pageController = PageController();
  int _pageIndex = 0;
  bool _editMode = false;
  var _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final _id = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.grey,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, JournalList.routeName);
          },
        ),
      ),
      floatingActionButton: _detailModeButton(),
      bottomNavigationBar: _bottomNavBar(),
      body: _buildJournalDetail(context, _id),
    );
  }

  StreamBuilder<Journal> _buildJournalDetail(BuildContext context, int id) {
    final dao = Provider.of<JournalDao>(context);
    return StreamBuilder(
      stream: dao.watchJournalEntry(id),
      builder: (context, AsyncSnapshot<Journal> snapshot) {
        final entry = snapshot.data;
        if ( !snapshot.hasData ) {
          return Center(child: Text("No data yet"),);
        }
        if ( _editMode ) {
          return Form(
            key: _formKey,
            child: PageView(
              scrollDirection: Axis.horizontal,
              onPageChanged: (value) {
                setState(() {
                  _pageIndex = value;
                });
              },
              controller: _pageController,
              children: <Widget>[
                _inputField(context, entry, _descriptionField(entry, dao), 'Describe the situation'),
                _inputField(context, entry, _feelingsField(entry, dao), 'What were you thinking or feeling?'),
                _inputField(context, entry, _evaluationField(entry, dao), 'What was good or bad about it?'),
                _inputField(context, entry, _analysisField(entry, dao), 'What can you make sense of it?'),
                _inputField(context, entry, _conclusionField(entry, dao), 'What else could you have done?'),
                _inputField(context, entry, _actionPlanField(entry, dao), 'What will you do for next time?'),
              ],
            ),
          );
        } else {
          return Padding(
            padding: EdgeInsets.only(right: 40, left: 40, bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  entry.title,
                  style: TextStyle(
                      fontFamily: 'Raleway',
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue[700]
                  ),
                ),
                Text(
                  DateFormat('M d, y hh:mm a').format(entry.dateCreated),
                  style: TextStyle(
                      color: Colors.grey
                  ),
                ),
                Expanded(child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 15.0),
                      child: Text(entry.description, style: TextStyle(fontSize: 16),),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15.0),
                      child: Text(entry.feelings, style: TextStyle(fontSize: 16),),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15.0),
                      child: Text(entry.evaluation, style: TextStyle(fontSize: 16),),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15.0),
                      child: Text(entry.analysis, style: TextStyle(fontSize: 16),),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15.0),
                      child: Text(entry.conclusion, style: TextStyle(fontSize: 16),),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15.0),
                      child: Text(entry.actionPlan, style: TextStyle(fontSize: 16),),
                    ),
                  ],
                ),)
              ]
            ),
          );
        }
      },
    );
  }

  _inputField(BuildContext context, Journal entry, field, String str) {
    final dao = Provider.of<JournalDao>(context);
    return SingleChildScrollView(
      padding: EdgeInsets.only(left: 40, right: 40, bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _titleField(entry, dao),
          _headerText(str),
          field,
        ],
      ),
    );
  }
  _headerText(String str) {
    return Text(
      str,
      style: TextStyle(
          fontFamily: 'Raleway',
          fontSize: 24,
          fontWeight: FontWeight.w300,
          color: Colors.blue[700]
      ),
    );
  }
  _titleField(Journal entry, JournalDao dao) {
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
        initialValue: entry.title,
        maxLines: null,
        decoration: InputDecoration(
          hintText: 'Enter entry title',
          hintStyle: TextStyle(fontSize: 20),
          border: InputBorder.none,
        ),
        onChanged: (value) => ( value.isNotEmpty) ? dao.updateJournalEntry(entry.copyWith(title: value)) : null,
      ),
    );
  }
  _descriptionField(Journal entry, JournalDao dao) {
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
        initialValue: entry.description,
        maxLines: null,
        decoration: InputDecoration(
          hintText: 'Consider the what, who, when, where, why and how.',
          hintMaxLines: 10,
          border: InputBorder.none,
        ),
        onChanged: (value) => ( value.isNotEmpty) ?  dao.updateJournalEntry(entry.copyWith(description: value)) : null,
      ),
    );
  }
  _feelingsField(Journal entry, JournalDao dao) {
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
        initialValue: entry.feelings,
        maxLines: null,
        decoration: InputDecoration(
          hintText: 'Consider the things you and other people contributed to the situation.',
          hintMaxLines: 10,
          border: InputBorder.none,
        ),
        onChanged: (value) => ( value.isNotEmpty) ?  dao.updateJournalEntry(entry.copyWith(feelings: value)) : null,
      ),
    );
  }
  _evaluationField(Journal entry, JournalDao dao) {
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
        initialValue: entry.evaluation,
        maxLines: null,
        decoration: InputDecoration(
          hintText: 'Consider the before, during, and after.',
          hintMaxLines: 10,
          border: InputBorder.none,
        ),
        onChanged: (value) => ( value.isNotEmpty) ?  dao.updateJournalEntry(entry.copyWith(evaluation: value)) : null,
      ),
    );
  }
  _analysisField(Journal entry, JournalDao dao) {
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
        initialValue: entry.analysis,
        maxLines: null,
        decoration: InputDecoration(
          hintText: 'Consider the things that helped or worsened the situation.',
          hintMaxLines: 10,
          border: InputBorder.none,
        ),
        onChanged: (value) => ( value.isNotEmpty) ?  dao.updateJournalEntry(entry.copyWith(analysis: value)) : null,
      ),
    );
  }
  _conclusionField(Journal entry, JournalDao dao) {
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
        initialValue: entry.conclusion,
        maxLines: null,
        decoration: InputDecoration(
          hintText: 'Consider whether you could and/or should have responded in a different way.',
          hintMaxLines: 10,
          border: InputBorder.none,
        ),
        onChanged: (value) => ( value.isNotEmpty) ?  dao.updateJournalEntry(entry.copyWith(conclusion: value)) : null,
      ),
    );
  }
  _actionPlanField(Journal entry, JournalDao dao) {
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
        initialValue: entry.actionPlan,
        maxLines: null,
        decoration: InputDecoration(
          hintText: 'Consider the things you need to know and/or do to improve for next time.',
          hintMaxLines: 10,
          border: InputBorder.none,
        ),
        onChanged: (value) => ( value.isNotEmpty) ?  dao.updateJournalEntry(entry.copyWith(actionPlan: value)) : null,
      ),
    );
  }
  _pageNavigation(int curr) {
    int _next;
    int _back;
    if ( curr == 0 ) {
      _back = 5;
      _next = curr + 1;
    } else if ( curr == 5 ) {
      _back = curr - 1;
      _next = 0;
    } else {
      _back = curr - 1;
      _next = curr + 1;
    }
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.navigate_before),
            onPressed: () => _pageController.jumpToPage(_back),
          ),
          DotsIndicator(
            dotsCount: 6,
            position: curr.toDouble(),
          ),
          IconButton(
            icon: Icon(Icons.navigate_next),
            onPressed: () => _pageController.jumpToPage(_next),
          ),
        ],
      ),
    );
  }
  _detailModeButton(){
    return FloatingActionButton(
      child: (_editMode) ? Icon(Icons.remove_red_eye) : Icon(Icons.edit),
      onPressed: () {
        if (_editMode == false){
          _pressState();
        }else{
          if (_formKey.currentState.validate()){
            _pressState();
          }
        }
      },
    );
  }
  _bottomNavBar() {
    return (_editMode) ? BottomAppBar(
      elevation: 0,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _pageNavigation(_pageIndex),
          bottomNavBar(context),
        ],
      ),
    ) : bottomNavBar(context);
  }

  _pressState(){
    setState(() {
      _editMode = !_editMode;
    });
  }
}