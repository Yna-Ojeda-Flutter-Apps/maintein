import 'package:dots_indicator/dots_indicator.dart';
import 'package:eit_app/screens/journal/journal_list.dart';
import 'package:eit_app/screens/widgets/bottomnavbar.dart';
import 'package:eit_app/utils/project_db.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:moor/moor.dart' as moorPackage;



class JournalNewForm extends StatefulWidget {
  static const routeName = '/journal_new';
  @override
  State<StatefulWidget> createState() {
    return _JournalNewFormState();
  }
}

class _JournalNewFormState extends State<JournalNewForm> {
  PageController _pageController = PageController();
  int _pageIndex = 0;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _feelingsController = TextEditingController();
  TextEditingController _evaluationController = TextEditingController();
  TextEditingController _analysisController = TextEditingController();
  TextEditingController _conclusionController = TextEditingController();
  TextEditingController _actionPlanController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
//      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _saveFormButton(),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _pageNavigation(_pageIndex),
            bottomNavBar(),
          ],
        ),
      ),
      body: PageView(
        scrollDirection: Axis.horizontal,
        controller: _pageController,
        children: <Widget>[
          _inputField(context, _descriptionField(), 'Describe the situation'),
          _inputField(context, _feelingsField(), 'What were you thinking or feeling?'),
          _inputField(context, _evaluationField(), 'What was good or bad about it?'),
          _inputField(context, _analysisField(), 'What can you make sense of it?'),
          _inputField(context, _conclusionField(),'What else could you have done?'),
          _inputField(context, _actionPlanField(),'What will you do for next time?')
        ],
        onPageChanged: (value) {
          setState(() {
            _pageIndex = value;
          });
        },
      ),
    );
  }

  _inputField(BuildContext context, field, String str) {
//    final dao = Provider.of<JournalDao>(context);
    return SingleChildScrollView(
      padding: EdgeInsets.only(left: 40, right: 40, bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _titleField(),
          _headerText(str),
          field,
        ],
      ),
    );


  }
  _titleField() {
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
        controller: _titleController,
        maxLines: null,
        decoration: InputDecoration(
          hintText: 'Enter entry title',
          hintStyle: TextStyle(fontSize: 20),
          border: InputBorder.none,
        ),
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
  _descriptionField() {
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
        controller: _descriptionController,
        maxLines: null,
        decoration: InputDecoration(
          hintText: 'Consider the what, who, when, where, why and how.',
          hintMaxLines: 10,
          border: InputBorder.none,
        ),
      ),
    );
  }
  _feelingsField() {
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
        controller: _feelingsController,
        maxLines: null,
        decoration: InputDecoration(
          hintText: 'Consider the before, during, and after.',
          hintMaxLines: 10,
          border: InputBorder.none,
        ),
      ),
    );
  }
  _evaluationField() {
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
        controller: _evaluationController,
        maxLines: null,
        decoration: InputDecoration(
          hintText: 'Consider the things you and other people contributed to the situation.',
          hintMaxLines: 10,
          border: InputBorder.none,
        ),
      ),
    );
  }
  _analysisField() {
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
        controller: _analysisController,
        maxLines: null,
        decoration: InputDecoration(
          hintText: 'Consider the things that helped or worsened the situation.',
          hintMaxLines: 10,
          border: InputBorder.none,
        ),
      ),
    );
  }
  _conclusionField() {
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
        controller: _conclusionController,
        maxLines: null,
        decoration: InputDecoration(
          hintText: 'Consider whether you could and/or should have responded in a different way.',
          hintMaxLines: 10,
          border: InputBorder.none,
        ),
      ),
    );
  }
  _actionPlanField() {
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
        controller: _actionPlanController,
        maxLines: null,
        decoration: InputDecoration(
          hintText: 'Consider the things you need to know and/or do to improve for next time.',
          hintMaxLines: 10,
          border: InputBorder.none,
        ),
      ),
    );
  }
  _validateAllForms() {
    return (
        _titleController.text.isNotEmpty &&
            _analysisController.text.isNotEmpty &&
            _conclusionController.text.isNotEmpty &&
            _evaluationController.text.isNotEmpty &&
            _feelingsController.text.isNotEmpty &&
            _descriptionController.text.isNotEmpty &&
            _actionPlanController.text.isNotEmpty
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
  _resetFields() {
    setState(() {
      _titleController.clear();
      _descriptionController.clear();
      _feelingsController.clear();
      _evaluationController.clear();
      _analysisController.clear();
      _conclusionController.clear();
      _actionPlanController.clear();
    });
    Navigator.pushNamed(context, JournalList.routeName);
  }
  _saveFormButton() {
    return FloatingActionButton(
      child: const Icon(Icons.done,),
      onPressed: ( _validateAllForms() ) ? () {
        final dao = Provider.of<JournalDao>(context);
        final entry = JournalsCompanion(
            title: moorPackage.Value(_titleController.text),
            dateCreated: moorPackage.Value(DateTime.now()),
            description: moorPackage.Value(_descriptionController.text),
            feelings: moorPackage.Value(_feelingsController.text),
            evaluation: moorPackage.Value(_evaluationController.text),
            analysis: moorPackage.Value(_analysisController.text),
            conclusion: moorPackage.Value(_conclusionController.text),
            actionPlan: moorPackage.Value(_analysisController.text)
        );
        dao.insertJournalEntry(entry);
        setState(() {
          _resetFields();
          _pageIndex = 0;
        });
      } : null,
    );
  }
}