import 'package:dots_indicator/dots_indicator.dart';
import 'package:maintein/widgets/bottomnavbar.dart';
import 'package:maintein/themes/apptheme.dart';
import 'package:maintein/utils/project_db.dart';
import 'package:maintein/widgets/journal/journal_form.dart';
import 'package:maintein/widgets/my_app_bar.dart';
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
  String _title;
  String _description;
  String _feelings;
  String _evaluation;
  String _analysis;
  String _conclusion;
  String _actionPlan;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: MyAppBar(appBarBottom: _pageNavigation(_pageIndex),),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _saveFormButton(),
      bottomNavigationBar: BottomNavBar(),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: PageView(
          scrollDirection: Axis.horizontal,
          controller: _pageController,
          children: <Widget>[
            JournalForm(
              titleInitialValue: _title,
              titleOnChanged: (value) { setState(() { _title = value; });},
              header: "Describe the Situation",
              textFieldInitialValue: _description,
              textFieldHint: "Consider the what, who, when, where, why, and why.",
              textFieldOnChanged: (value) { setState(() { _description = value; });},
            ),
            JournalForm(
              titleInitialValue: _title,
              titleOnChanged: (value) { setState(() { _title = value; });},
              header: "What where you thinking or feeling?",
              textFieldInitialValue: _feelings,
              textFieldHint: "Consider the before, during, and after.",
              textFieldOnChanged: (value) { setState(() { _feelings = value; });},
            ),
            JournalForm(
              titleInitialValue: _title,
              titleOnChanged: (value) { setState(() { _title = value; });},
              header: "What was good or bad about it?",
              textFieldInitialValue: _evaluation,
              textFieldHint: "Consider the things you and other people contributed to the situation..",
              textFieldOnChanged: (value) { setState(() { _evaluation = value; });},
            ),
            JournalForm(
              titleInitialValue: _title,
              titleOnChanged: (value) { setState(() { _title = value; });},
              header: "What can you make sense of it?",
              textFieldInitialValue: _analysis,
              textFieldHint: "Consider the things that helped or worsened the situation.",
              textFieldOnChanged: (value) { setState(() { _analysis = value; });},
            ),
            JournalForm(
              titleInitialValue: _title,
              titleOnChanged: (value) { setState(() { _title = value; });},
              header: "What else could you have done?",
              textFieldInitialValue: _conclusion,
              textFieldHint: "Consider whether you could and/or should have responded in a different way.",
              textFieldOnChanged: (value) { setState(() { _conclusion = value; });},
            ),
            JournalForm(
              titleInitialValue: _title,
              titleOnChanged: (value) { setState(() { _title = value; });},
              header: "What will you do for next time?",
              textFieldInitialValue: _actionPlan,
              textFieldHint: "Consider the things you need to know and/or do to improve for next time.",
              textFieldOnChanged: (value) { setState(() { _actionPlan = value; });},
            ),
          ],
          onPageChanged: (value){
            setState(() {
              _pageIndex = value;
            });
          },
        ),
      ),
    );
  }

  bool _validateAll() {
    _title = _title ?? "";
    _description = _description ?? "";
    return ( (_title.length > 0) && (_description.length > 0) );
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
            decorator: DotsDecorator(activeColor: MyBlue.seagull),
          ),
          IconButton(
            icon: Icon(Icons.navigate_next),
            onPressed: () => _pageController.jumpToPage(_next),
          ),
        ],
      ),
    );
  }

  _saveFormButton() {
    return FloatingActionButton(
      backgroundColor: (_validateAll()) ? MyBlue.picton : Colors.grey,
      foregroundColor: Colors.white,
      child: const Icon(Icons.done,),
      onPressed: () async {
        if ( _validateAll() ) {
          final dao = Provider.of<JournalDao>(context);
          final entry = JournalsCompanion(
              title: moorPackage.Value(_title),
              dateCreated: moorPackage.Value(DateTime.now()),
              description: moorPackage.Value(_description),
              feelings: moorPackage.Value(_feelings),
              evaluation: moorPackage.Value(_evaluation),
              analysis: moorPackage.Value(_analysis),
              conclusion: moorPackage.Value(_conclusion),
              actionPlan: moorPackage.Value(_actionPlan)
          );
          await dao.insertJournalEntry(entry);
        }
        setState(() {
          _title = "";
          _description = "";
          _feelings = "";
          _evaluation = "";
          _analysis = "";
          _conclusion = "";
          _actionPlan = "";
          _pageIndex = 0;
        });
        Navigator.of(context).pop();
        _newEntryFeedback(context);
      },
    );
  }

  void _newEntryFeedback(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
            title: Text("Nice one, a new entry!"),
            content: Text("Each entry is a step deeper into learning about and expressing yourself."),
            actions: <Widget>[
              FlatButton(child: Text("Okay"), onPressed: () => Navigator.of(context).pop())
            ],
          );
        }
    );
  }

}