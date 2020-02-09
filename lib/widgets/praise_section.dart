import 'package:eit_app/utils/const_list_and_enum.dart';
import 'package:eit_app/utils/list_filters.dart';
import 'package:eit_app/utils/project_db.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


Padding praiseSection(BuildContext context, int entryCount, List<String> praise) {
  return Padding(
    padding: EdgeInsets.only(right: 40.0, left: 40.0, top: 20, bottom: 20),
    child: Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 30.0),
          child: Image(
            image: ( entryCount >= 3 ) ? AssetImage('lib/assets/images/praise/popper.png') : AssetImage('lib/assets/images/praise/confetti.png'),
            width: 50.0,
            height: 50.0,
          ),
        ),
        Expanded(
          child: Text(
            ( entryCount >= 3 ) ? praise[1] : praise[0],
            style: Theme.of(context).textTheme.body1.copyWith(fontSize: 16),
          ),
        ),
      ],
    ),
  );
}

class PraiseSection extends StatefulWidget {
  final bool isJournal;

  PraiseSection({this.isJournal});

  @override
  State<StatefulWidget> createState() => _PraiseSectionState();
}

class _PraiseSectionState extends State<PraiseSection>{
  @override
  Widget build(BuildContext context) {
    if ( widget.isJournal ?? true ) {
      final dao = Provider.of<JournalDao>(context);
      return StreamBuilder(
          stream: dao.watchAllEntries(),
          builder: (context, AsyncSnapshot<List<Journal>> snapshot) {
            if ( !snapshot.hasData ) {
              return Image(
                image: AssetImage('lib/assets/images/data/loading.png'),
                height: 300,
              );
            }
            List<Journal> records = snapshot.data ?? List<Journal>();
            records = filterJournalRecords(records, DateFilter.Today);

            if ( records.length > 0 ) {
              return Padding(
                padding: EdgeInsets.only(right: 40.0, left: 40.0, top: 20, bottom: 10),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 30.0),
                      child: Image(
                        image: ( records.length  >= 3 ) ? AssetImage('lib/assets/images/praise/popper.png') : AssetImage('lib/assets/images/praise/confetti.png'),
                        width: 50.0,
                        height: 50.0,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        ( records.length > 1 ) ? journalPraise[1] : journalPraise[0],
                        style: Theme.of(context).textTheme.body1.copyWith(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Container();
            }
          }
      );

    } else {
      final dao = Provider.of<ListenDao>(context);
      return StreamBuilder(
          stream: dao.watchAll(),
          builder: (context, AsyncSnapshot<List<Listen>> snapshot) {
            if ( !snapshot.hasData ) {
              return Image(
                image: AssetImage('lib/assets/images/data/loading.png'),
                height: 300,
              );
            }
            List<Listen> records = snapshot.data ?? List<Listen>();
            records = filterListenRecords(records, DateFilter.Today);

            if ( records.length > 0 ) {
              return Padding(
                padding: EdgeInsets.only(right: 40.0, left: 40.0, top: 20, bottom: 10),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 30.0),
                      child: Image(
                        image: ( records.length  >= 3 ) ? AssetImage('lib/assets/images/praise/popper.png') : AssetImage('lib/assets/images/praise/confetti.png'),
                        width: 50.0,
                        height: 50.0,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        ( records.length > 1 ) ? conversationPraise[1] : conversationPraise[0],
                        style: Theme.of(context).textTheme.body1.copyWith(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Container();
            }
          }
      );

    }
  }
}

