import 'package:eit_app/screens/assessments/assessments_list.dart';
import 'package:eit_app/screens/widgets/bottomnavbar.dart';
import 'package:eit_app/utils/project_db.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:moor/moor.dart' as moorPackage;


class TakeAssessment extends StatefulWidget {
  static const routeName = 'take_assessment';
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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.grey,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, AssessmentsList.routeName);
          },
        ),
      ),
//      floatingActionButton: _submitAssessmentButton(),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildChoice(_pageIndex, 5),
            _buildChoice(_pageIndex, 4),
            _buildChoice(_pageIndex, 3),
            _buildChoice(_pageIndex, 2),
            _buildChoice(_pageIndex, 1),
            _submitAssessmentButton(),
            _pageNavigation(_pageIndex),
            bottomNavBar(),
          ],
        ),
      ),
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
          return _buildPage(position);
        },
      ),
    );
  }
  _buildPage(int position) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(left: 40, right: 40, bottom: 10),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 20),
            child: Text(
              (_isMWB) ? _mwbQuestions[position] : _eisQuestions[position],
              style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue[700]
              ),
            ),
          ),
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
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Color(0xff21BEDE),
        child: Text(
          (_isMWB) ? _mwbChoices[choiceValue-1] : _eisChoices[choiceValue-1],
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
        color: Color(0xff21BEDE),
        borderSide: BorderSide(
          color: Color(0xff21BEDE), //Color of the border
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
          (_isMWB) ? _mwbChoices[choiceValue-1] : _eisChoices[choiceValue-1],
          style: TextStyle(
              color: Color(0xff21BEDE),
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
      backgroundColor: ( _validateFields() ) ? Color(0xff21BEDE) : Colors.grey,
      elevation: 1,
      onPressed: () async {
        if ( _validateFields() ) {
          final dao = Provider.of<AssessmentDao>(context);
          final entry = AssessmentsCompanion(
            isMWB: moorPackage.Value(_isMWB),
            dateCreated: moorPackage.Value(DateTime.now())
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

const List<String> _mwbQuestions = [
  'My life is on the right track',
  'I wish I could change some part of my life',
  'My future looks good',
  'I feel as though the best years of my life are over',
  'I like myself',
  'I feel there must be something wrong with me',
  'I can handle any problems that come up',
  'I feel like a failure',
  'I feel loved and trusted',
  'I seem to be left alone when I don’t want to be',
  'I feel close to people around me',
  'I have lost interest in other people and don’t care about them',
  'I feel I can do whatever I want to',
  'My life seems stuck in a rut',
  'I have energy to spare',
  'I can’t be bothered doing anything',
  'I smile and laugh a lot',
  'Nothing seems very much fun anymore',
  'I think clearly and creatively',
  'My thoughts go around in useless circles',
  'Satisfied',
  'Disconnected',
  'Optimistic',
  'Hopeless',
  'Useful',
  'Insignificant',
  'Confident',
  'Helpless',
  'Understood',
  'Lonely',
  'Loving',
  'Withdrawn',
  'Free-and-easy',
  'Tense',
  'Enthusiastic',
  'Depressed',
  'Good-natured',
  'Impatient',
  'Clear-headed',
  'Confused',
];

const _eisQuestions = [
  'I know when to speak about my personal problems to others',
  'When I am faced with obstacles, I remember times I faced similar obstacles and overcame them',
  'I expect that I will do well on most things I try',
  'Other people find it easy to confide in me',
  'I find it hard to understand the non-verbal messages of other people',
  'Some of the major events of my life have led me to re-evaluate what is important and not important',
  'When my mood changes, I see new possibilities',
  'Emotions are one of the things that make my life worth living',
  'I am aware of my emotions as I experience them',
  'I expect good things to happen',
  'I like to share my emotions with others',
  'When I experience a positive emotion, I know how to make it last',
  'I arrange events others enjoy',
  'I seek out activities that make me happy',
  'I am aware of the non-verbal messages I send to others',
  'I present myself in a way that makes a good impression on others',
  'When I am in a positive mood, solving problems is easy for me',
  'By looking at their facial expressions, I recognize the emotions people are experiencing',
  'I know why my emotions changes',
  'When I am in a positive mood, I am able to come up with new ideas',
  'I have control over my emotions',
  'I easily recognize my emotions as I experience them',
  'I motivate myself by imagining a good outcome to tasks I take on',
  'I compliment others when they have done something well',
  'I am aware of the non-verbal messages other people send',
  'When another person tells me about an important event in his or her life, I almost feel as though I experienced this myself',
  'When I feel a change in emotions, I tend to come up with new ideas',
  'When I am faced with a challenge, I give up because I believe I will fail',
  'I know what other people are feeling just by looking at them',
  'I help other people feel better when they are down',
  'I use good moods to help myself keep trying in the face of obstacles',
  'I can tell how people are feeling by listening to the tone of their voice',
  'It is difficult for me to understand why people feel the way they do',
];

List<String> _mwbChoices = [
  'Not at all',
  'Occassionally',
  'Some of the time',
  'Often',
  'All of the time',
];

List<String> _eisChoices = [
  'Strongly Disagree',
  'Somewhat Disagree',
  'Neither Agree nor Disagree',
  'Somewhat Agree',
  'Strongly Agree',
];