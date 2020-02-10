import 'package:maintein/screens/assessments/assessments_list.dart';
import 'package:maintein/utils/const_list_and_enum.dart';
import 'package:maintein/widgets/bottomnavbar.dart';
import 'package:maintein/themes/apptheme.dart';
import 'package:maintein/utils/project_db.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:moor/moor.dart' as moorPackage;


class TakeAssessment extends StatefulWidget {
  static const routeName = '/take_assessment';
  @override
  State<StatefulWidget> createState() {
    return _TakeAssessmentState();
  }
}
class _TakeAssessmentState extends State<TakeAssessment> {
  PageController _pageController = PageController();
  List<int> _assessmentValues = List<int>.filled(40, 0);
  int _pageIndex = 0;
  bool _isMWB = true;

  @override
  Widget build(BuildContext context) {
    setState(() {
      _isMWB = ModalRoute.of(context).settings.arguments ?? true;
    });
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          elevation: 0,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: _pageNavigation(_pageIndex),
          ),
        ),
      ),
      floatingActionButton: _submitAssessmentButton(),
      bottomNavigationBar: BottomNavBar(),
      body: PageView.builder(
        scrollDirection: Axis.horizontal,
        controller: _pageController,
        onPageChanged: (value) {
          setState(() {
            _pageIndex = value;
          });
        },
        itemCount: (_isMWB) ? 40 : 33,
        itemBuilder: (context, position) {
          return _buildQuestionPage(position);
        },
      ),
    );
  }

  _buildQuestionPage(int position) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              Text(
                (_isMWB) ? mwbQuestions[position] : eisQuestions[position],
                style: Theme.of(context).textTheme.title.copyWith(color: MyBlue.picton),
                textAlign: TextAlign.center,
              )
            ]),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  _buildChoice(_pageIndex, 5),
                  _buildChoice(_pageIndex, 4),
                  _buildChoice(_pageIndex, 3),
                  _buildChoice(_pageIndex, 2),
                  _buildChoice(_pageIndex, 1)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _buildChoice(int index, int choiceValue) {
    return Container(
      padding: EdgeInsets.only(left: 40, right: 40, bottom: 10),
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: ( _assessmentValues[index] == choiceValue ) ?
      FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        color: MyBlue.light,
        child: Text(
          (_isMWB) ? mwbChoices[choiceValue-1] : eisChoices[choiceValue-1],
          style: TextStyle(
            color: Colors.white
          ),
        ),
        onPressed: () {
          setState(() {
            _assessmentValues[index] = choiceValue;
          });
          if ( _pageIndex != ((_isMWB) ? 39 : 32) ){
            _pageController.jumpToPage(_pageIndex+1);
          }
        },
      ) : OutlineButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: MyBlue.light,
        borderSide: BorderSide(
          color: MyBlue.light, //Color of the border
          style: BorderStyle.solid, //Style of the border
          width: 0.8, //width of the border
        ),
        onPressed: () {
          setState(() {
            _assessmentValues[index] = choiceValue;
          });
          if ( _pageIndex != ((_isMWB) ? 39 : 32) ){
            _pageController.jumpToPage(_pageIndex+1);
          }
        },
        child: Text(
          (_isMWB) ? mwbChoices[choiceValue-1] : eisChoices[choiceValue-1],
          style: TextStyle(
              color: MyBlue.light,
          ),
        ),
      ),
    );
  }
  _pageNavigation(int curr) {
    int _next;
    int _back;
    if ( curr == 0 ) {
      _back = (_isMWB) ? 39 : 32;
      _next = curr + 1;
    } else if ( curr == ((_isMWB) ? 39 : 32) ) {
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
          Text(
            '${_pageIndex+1}/${(_isMWB) ? 40 : 33 }'
          ),
          IconButton(
            icon: Icon(Icons.navigate_next),
            onPressed: () => _pageController.jumpToPage(_next),
          ),
        ],
      ),
    );
  }
  _validateFields() {
    for ( int i = 0; i < ((_isMWB) ? 40 : 33); i++ ) {
      if ( _assessmentValues[i] == 0 ){
        return false;
      }
    }
    return true;
  }
  FloatingActionButton _submitAssessmentButton() {
    return FloatingActionButton(
      backgroundColor: ( _validateFields() ) ? MyBlue.light : Colors.grey,
      foregroundColor: Colors.white,
      elevation: 1,
      onPressed: () async {
        if ( _validateFields() ) {
          final dao = Provider.of<AssessmentDao>(context);
          final entry = AssessmentsCompanion(
            isMWB: moorPackage.Value(_isMWB),
            dateCreated: moorPackage.Value(DateTime.now()),
            score: moorPackage.Value(_calculateScore(_assessmentValues, _isMWB))
          );
          final entryId = await dao.insertAssessment(entry);
          for ( int i = 0; i < ((_isMWB) ? 40 : 33); i++ ) {
            var _question = QuestionsCompanion(
                id: moorPackage.Value(entryId),
                qId: moorPackage.Value(i),
                score: moorPackage.Value(_assessmentValues[i])
            );
            dao.insertQuestion(_question);
          }
          setState(() {
            _resetFields();
            _pageIndex = 0;
          });
          Navigator.pushNamed((context), AssessmentsList.routeName);
        }
      },
      tooltip: 'Submit Assessment',
      child: Icon(Icons.done),
    );
  }
  _resetFields() {
    for ( int i = 0; i < _assessmentValues.length; i++ ) {
      _assessmentValues[i] = 0;
    }
  }
}

int _calculateScore(List<int> questions, bool isMWB) {
  int _score = 0;
  if ( isMWB ) {
    for ( int i = 0; i < 40; i++ ) {
      _score = _score + questions[i];
      i = i + 1;
      _score = _score - questions[i];
    }
    _score = (((_score + 80) * 100)~/160);
  } else {
    for ( int i = 0; i < 33; i++ ) {
      if ( (i == 4) || (i == 27) || (i == 32) ) {
        _score = _score + (6 - questions[i]);
      } else {
        _score = _score + questions[i];
      }
    }
  }
  return _score;
}
