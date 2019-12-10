import 'package:eit_app/assets/icons/emoji_icons_icons.dart';
import 'package:eit_app/screens/assessments/assessments_form.dart';
import 'package:eit_app/screens/widgets/bottomnavbar.dart';
import 'package:eit_app/utils/project_db.dart';
//import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class AssessmentsList extends StatefulWidget {
  static const routeName = '/assessments_list';
  @override
  State<StatefulWidget> createState() {
    return _AssessmentsListState();
  }
}

class _AssessmentsListState extends State<AssessmentsList> {
  int _tabIndex = 1;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: 2,
      child: Builder(builder: (BuildContext context){
        return Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            centerTitle: true,
            elevation: 1,
            backgroundColor: Colors.white,
            title: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                'Assessments',
                style: TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey[800]
                ),
              ),
            ),
            bottom: TabBar(
              labelColor: Color(0xFF21BEDE),
              indicatorColor: Color(0xFF21BEDE),
              unselectedLabelColor: Colors.grey[800],
              tabs: <Widget>[
                Tab(
                  text: 'Mental Well Being',
                ),
                Tab(
                  text: 'Emotional Intelligence',
                )
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 10, left: 40, right: 40),
                child: _buildMWBRecordList(context),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 10, left: 40, right: 40),
                child: _buildEISRecordList(context),
              ),
            ],
          ),
          bottomNavigationBar: bottomNavBar(context),
          floatingActionButton: _takeQuizButton(context),
        );
      }),
    );
  }

  StreamBuilder<List<AssessmentRecord>> _buildMWBRecordList(BuildContext context) {
    final dao = Provider.of<AssessmentDao>(context);
    return StreamBuilder(
      stream: dao.watchAllMWB(),
      builder: (context, AsyncSnapshot<List<AssessmentRecord>> snapshot) {
        final records = snapshot.data ?? List();
        return ListView.builder(
          itemCount: records.length,
          itemBuilder: (_, index) {
            final record = records[index];
            return _buildMWBRecordItem(record, dao);
          },
        );
      },
    );
  }
  Widget _buildMWBRecordItem(AssessmentRecord record, AssessmentDao dao) {
    int _score = _calculateScore(_cleanList(record.question), true);
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          icon: Icons.delete,
          onTap: () => dao.deleteAssessment(record.info),
        )
      ],
      child: Card(
        color: Colors.white,
        child: InkWell(
          onTap: () => debugPrint('hi'),
          child: Padding(
            padding: EdgeInsets.only(right: 20, bottom: 10, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 100,
                  child: _leadingIcon(_score, true),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        DateFormat('MMMM dd, y').format(record.info.dateCreated),
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Raleway'
                        ),
                      ),
                      Text(
                        '${DateFormat('hh:mm a').format(record.info.dateCreated)} | ${_assessmentResult(_score, true)}',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  StreamBuilder<List<AssessmentRecord>> _buildEISRecordList(BuildContext context) {
    final dao = Provider.of<AssessmentDao>(context);
    return StreamBuilder(
      stream: dao.watchAllEIS(),
      builder: (context, AsyncSnapshot<List<AssessmentRecord>> snapshot) {
        final records = snapshot.data ?? List();
        return ListView.builder(
          itemCount: records.length,
          itemBuilder: (_, index) {
            final record = records[index];
            return _buildEISRecordItem(record, dao);
          },
        );
      },
    );
  }
  Widget _buildEISRecordItem(AssessmentRecord record, AssessmentDao dao) {
    int _score = _calculateScore(_cleanList(record.question), false);
    final _qlist = _cleanList(record.question);
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          icon: Icons.delete,
          onTap: () => dao.deleteAssessment(record.info),
        )
      ],
      child: Card(
        color: Colors.white,
        child: InkWell(
          onTap: () => {
            for ( int i = 0; i < _qlist.length; i++) {
              debugPrint('${_qlist[i].qId} => ${_qlist[i].score}')
            }

          },
          child: Padding(
            padding: EdgeInsets.only(right: 20, bottom: 10, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 100,
                  child: _leadingIcon(_score, false),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        DateFormat('MMMM dd, y').format(record.info.dateCreated),
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Raleway'
                        ),
                      ),
                      Text(
                        '${DateFormat('hh:mm a').format(record.info.dateCreated)} | ${_assessmentResult(_score, false)}',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


  int _calculateScore(List<Question> questions, bool isMWB) {
    int _score = 0;
    if ( isMWB ) {
      for ( int i = 0; i < questions.length; i++ ) {
        _score = _score + questions[i].score;
        i = i + 1;
        _score = _score - questions[i].score;
      }
      _score = (((_score + 80) * 100)~/160);
    } else {
      for ( int i = 0; i < questions.length; i++ ) {
        if ( (i == 4) || (i == 27) || (i == 32) ) {
          _score = _score + (6 - questions[i].score);
        } else {
          _score = _score + questions[i].score;
        }
      }
//      _score = ((_score * 100)~/165);
    }
    return _score;
  }
  _cleanList(_list) {
    for ( int ctr = 0; ctr < _list.length; ctr++ ) {
      if ( _list[ctr] == null ) {
        _list.remove(_list[ctr]);
      }
    }
    return _list;
  }
  _leadingIcon(int score, bool isMWB) {
    double _iconSize = 50;
    if ( isMWB ) {
      if ( score < 25 ) {
        return Icon(EmojiIcons.awful, color: Color(0xFF21BEDE), size: _iconSize,);
      } else if ( score > 25 && score < 50 ) {
        return Icon(EmojiIcons.bad, color: Color(0xFF21BEDE), size: _iconSize,);
      } else if ( score == 50 ) {
        return Icon(EmojiIcons.moderate, color: Color(0xFF21BEDE), size: _iconSize,);
      } else if ( score > 50 && score < 75 ) {
        return Icon(EmojiIcons.good, color: Color(0xFF21BEDE), size: _iconSize,);
      } else {
        return Icon(EmojiIcons.excellent, color: Color(0xFF21BEDE), size: _iconSize,);
      }
    } else {
      return Padding(
        padding: EdgeInsets.only(left: 25),
        child: Text(
          score.toString(),
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 30,
            fontFamily: 'Raleway',
            color: Color(0xFF21BEDE)
          ),
        ),
      );
    }
  }
  String _assessmentResult(int score, bool isMWB) {
    if ( isMWB) {
      if ( score < 25 ) {
        return 'Awful';
      } else if ( score > 25 && score < 50 ) {
        return 'Bad';
      } else if ( score == 50 ) {
        return 'Alright';
      } else if ( score > 50 && score < 75 ) {
        return 'Good';
      } else {
        return 'Excellent';
      }
    } else {
      if ( score < 111 ) {
        return 'Low';
      } else if  ( score > 137 ) {
        return 'High';
      } else {
        return 'Average';
      }
    }
  }
  FloatingActionButton _takeQuizButton(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Color(0xff21BEDE),
      onPressed: () {
        _tabIndex = DefaultTabController.of(context).index;
        ( _tabIndex == 0 ) ? Navigator.pushNamed(context, TakeAssessment.routeName, arguments: true) : Navigator.pushNamed(context, TakeAssessment.routeName, arguments: false);
      },
      tooltip: 'Take Assessment',
      child: Icon(Icons.add),
    );
  }
}