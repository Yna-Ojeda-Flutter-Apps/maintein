import 'package:eit_app/assets/icons/emoji_icons_icons.dart';
import 'package:eit_app/themes/apptheme.dart';
import 'package:eit_app/utils/project_db.dart';
import 'package:eit_app/widgets/my_slidable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AssessmentRecordList extends StatefulWidget {
  final bool isMWB;
  AssessmentRecordList({this.isMWB});
  @override
  State<StatefulWidget> createState() => _AssessmentRecordListState();

}

class _AssessmentRecordListState extends State<AssessmentRecordList>{
  @override
  Widget build(BuildContext context) {
    final dao = Provider.of<AssessmentDao>(context);
    return StreamBuilder(
      stream: (widget.isMWB) ? dao.watchAllMWB() : dao.watchAllEIS(),
      builder: (context, AsyncSnapshot<List<Assessment>> snapshot) {
        if ( !snapshot.hasData ) {
          return Image(
            image: AssetImage('lib/assets/images/data/loading.png'),
            height: 300,
          );
        }
        var records = snapshot.data ?? List();
        if ( records.length < 1 ) {
          return Image(
            image: AssetImage('lib/assets/images/data/no_data.png'),
            height: 300,
          );
        } else {
          return ListView.builder(
            itemCount: records.length,
            itemBuilder: (_, index) {
              final record = records[index];
              return MySlidable(
                onTap: () async => await dao.deleteAssessment(record),
                child: Container(
                  height: 75,
                  child: Card(
                    elevation: 2.0,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 100,
                          child: _leadingIcon(record.score, widget.isMWB),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                DateFormat('MMMM dd, y').format(record.dateCreated),
                                style: Theme.of(context).textTheme.subhead.copyWith(color: MyBlue.picton),
                              ),
                              Text(
                                '${DateFormat('hh:mm a').format(record.dateCreated)} | ${_assessmentResult(record.score, widget.isMWB)}',
                                style: Theme.of(context).textTheme.subtitle.copyWith(color: Colors.grey),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
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
}