import 'package:dots_indicator/dots_indicator.dart';
import 'package:maintein/utils/project_db.dart';
import 'package:maintein/widgets/bottomnavbar.dart';
import 'package:maintein/themes/apptheme.dart';
import 'package:maintein/widgets/journal/journal_detail_view.dart';
import 'package:maintein/widgets/journal/journal_form.dart';
import 'package:maintein/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JournalDetail extends StatefulWidget {
  static const routeName = '/journal_detail';
  @override
  State<StatefulWidget> createState() => _JournalDetailState();
}

class _JournalDetailState extends State<JournalDetail> {
  PageController _pageController = PageController();
  int _pageIndex = 0;
  final _maxPageIndex = 5;
  bool _editMode = false;
  @override
  Widget build(BuildContext context) {
    final _id = ModalRoute.of(context).settings.arguments;
    final dao = Provider.of<JournalDao>(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: (_editMode) ? MyAppBar(appBarBottom: _pageNavigation(_pageIndex),) : AppBar(elevation: 0.0, automaticallyImplyLeading: false, backgroundColor: Colors.white,),
      ),
      floatingActionButton: _detailModeButton(),
      bottomNavigationBar: BottomNavBar(),
      body: (_editMode) ? StreamBuilder(
        stream: dao.watchJournalEntry(_id),
        builder: (context, AsyncSnapshot<Journal> snapshot) {
          if ( !snapshot.hasData ) {
            return Center(
              child:CircularProgressIndicator(),
            );
          }
          Journal record = snapshot.data;
          return Padding(
            padding: EdgeInsets.all(10.0),
            child: PageView(
              scrollDirection: Axis.horizontal,
              controller: _pageController,
              onPageChanged: (value){
                setState(() {
                  _pageIndex = value;
                });
              },
              children: <Widget>[
                JournalForm(
                  titleInitialValue: record.title,
                  titleOnChanged: (value) { setState(() {
                    if ( value.length > 0 ) {
                      dao.updateJournalEntry(record.copyWith(title: value));
                    }
                  });},
                  header: "Describe the Situation",
                  textFieldInitialValue: record.description,
                  textFieldHint: "Consider the what, who, when, where, why, and why.",
                  textFieldOnChanged: (value) { setState(() {
                    if ( value.length > 0 ) {
                      dao.updateJournalEntry(record.copyWith(description: value));
                    }
                  });},
                ),
                JournalForm(
                  titleInitialValue: record.title,
                  titleOnChanged: (value) { setState(() {
                    if ( value.length > 0 ) {
                      dao.updateJournalEntry(record.copyWith(title: value));
                    }
                  });},
                  header: "What where you thinking or feeling?",
                  textFieldInitialValue: record.feelings,
                  textFieldHint: "Consider the before, during, and after.",
                  textFieldOnChanged: (value) { setState(() {
                    dao.updateJournalEntry(record.copyWith(feelings: value));
                  });},
                ),
                JournalForm(
                  titleInitialValue: record.title,
                  titleOnChanged: (value) { setState(() {
                    if ( value.length > 0 ) {
                      dao.updateJournalEntry(record.copyWith(title: value));
                    }
                  });},
                  header: "What was good or bad about it?",
                  textFieldInitialValue: record.evaluation,
                  textFieldHint: "Consider the things you and other people contributed to the situation..",
                  textFieldOnChanged: (value) { setState(() {
                    dao.updateJournalEntry(record.copyWith(evaluation: value));
                  });},
                ),
                JournalForm(
                  titleInitialValue: record.title,
                  titleOnChanged: (value) { setState(() {
                    if ( value.length > 0 ) {
                      dao.updateJournalEntry(record.copyWith(title: value));
                    }
                  });},
                  header: "What can you make sense of it?",
                  textFieldInitialValue: record.analysis,
                  textFieldHint: "Consider the things that helped or worsened the situation.",
                  textFieldOnChanged: (value) { setState(() {
                    dao.updateJournalEntry(record.copyWith(analysis: value));
                  });},
                ),
                JournalForm(
                  titleInitialValue: record.title,
                  titleOnChanged: (value) { setState(() {
                    if ( value.length > 0 ) {
                      dao.updateJournalEntry(record.copyWith(title: value));
                    }
                  });},
                  header: "What else could you have done?",
                  textFieldInitialValue: record.conclusion,
                  textFieldHint: "Consider whether you could and/or should have responded in a different way.",
                  textFieldOnChanged: (value) { setState(() {
                    dao.updateJournalEntry(record.copyWith(conclusion: value));
                  });},
                ),
                JournalForm(
                  titleInitialValue: record.title,
                  titleOnChanged: (value) { setState(() {
                    if ( value.length > 0 ) {
                      dao.updateJournalEntry(record.copyWith(title: value));
                    }
                  });},
                  header: "What will you do for next time?",
                  textFieldInitialValue: record.actionPlan,
                  textFieldHint: "Consider the things you need to know and/or do to improve for next time.",
                  textFieldOnChanged: (value) { setState(() {
                    dao.updateJournalEntry(record.copyWith(actionPlan: value));
                  });},
                ),
              ],
            ),
          );
        },
      ) : JournalDetailViewMode(id: _id,),
    );
  }

  
  _pageNavigation(int curr) {
    int _next;
    int _back;
    if ( curr == 0 ) {
      _back = _maxPageIndex;
      _next = curr + 1;
    } else if ( curr == _maxPageIndex ) {
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
  _detailModeButton(){
    return FloatingActionButton(
        tooltip: (_editMode) ?  "View Mode" : "Edit Mode",
        backgroundColor: MyBlue.picton,
        foregroundColor: Colors.white,
        child: (_editMode) ? Icon(Icons.remove_red_eye) : Icon(Icons.edit),
        onPressed:(){
          setState(() {
            _editMode = !_editMode;
          });
        });
  }


}