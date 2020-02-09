import 'package:eit_app/screens/journal/journal_detail.dart';
import 'package:eit_app/themes/apptheme.dart';
import 'package:eit_app/utils/const_list_and_enum.dart';
import 'package:eit_app/utils/list_filters.dart';
import 'package:eit_app/utils/project_db.dart';
import 'package:eit_app/widgets/my_slidable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';



class JournalRecordList extends StatefulWidget {
  final DateFilter currentFilter;

  JournalRecordList({this.currentFilter});

  @override
  State<StatefulWidget> createState() => _JournalRecordListState();

}

class _JournalRecordListState extends State<JournalRecordList>{
  @override
  Widget build(BuildContext context) {
    final JournalDao dao = Provider.of<JournalDao>(context);
    return StreamBuilder(
      stream: dao.watchAllEntries(),
      builder: (context, AsyncSnapshot<List<Journal>> snapshot) {
        if ( !snapshot.hasData ) {
          return SliverList(delegate: SliverChildListDelegate([Image(
            image: AssetImage('lib/assets/images/data/loading.png'),
            height: 300,
          )]),);
        }
        List<Journal> records = snapshot.data ?? List<Journal>();
        records = filterJournalRecords(records, widget.currentFilter);
        if ( records.length < 1 ) {
          return SliverList(delegate: SliverChildListDelegate([Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage('lib/assets/images/data/content.png'),
                height: 300,
              ),
              Text("Learn more about yourself and add an entry.", style: Theme.of(context).textTheme.subhead.copyWith(color: Colors.grey[600]),),
            ],
          )]),);
        }
        return SliverList(
          delegate: SliverChildBuilderDelegate((BuildContext context, index) {
            return MySlidable(
              onTap: () => _confirmDelete(context, records[index], dao),
              child: Card(
                color: Colors.white,
                elevation: 3.0,
                child: InkWell(
                  onTap: () => Navigator.pushNamed(context, JournalDetail.routeName, arguments: records[index].id),
                  child: Padding(
                    padding: EdgeInsets.only(right:20, bottom: 10, top:10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min ,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 100,
                          child: Column(
                            children: <Widget>[
                              Text(
                                DateFormat('MMM').format(records[index].dateCreated),
                                style: TextStyle(
                                  color: MyBlue.light,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                DateFormat('dd').format(records[index].dateCreated),
                                style: TextStyle(
                                  color: MyBlue.light,
                                  fontSize: 30,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex:1,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top:10),
                                child:Text(records[index].title ?? "", style: Theme.of(context).textTheme.subhead,),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 5),
                                child: Text(
                                  DateFormat('hh:mm a').format(records[index].dateCreated), style: Theme.of(context).textTheme.subtitle, textAlign: TextAlign.left,),
                              ),
                              Text(
                                ( records[index].description.length > 115 ) ? records[index].description.substring(0, 115) + " ..." : records[index].description,
                                textAlign: TextAlign.justify,
                                style: Theme.of(context).textTheme.body1,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
            ),
            );
          }, childCount: records.length),
        );
      },
    );
  }

  void _confirmDelete(BuildContext context, Journal entry, JournalDao dao) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
            title: Text("Delete '"+entry.title+"'?"),
            content: Text("Deleting this entry cannot be undone."),
            actions: <Widget>[
              FlatButton(child: Text('Cancel'), onPressed: () => Navigator.of(context).pop(),),
              FlatButton(
                child: Text('Delete', style: TextStyle(color: Colors.redAccent),),
                onPressed: () async {
                  dao.deleteJournalEntry(entry);
                  Navigator.of(context).pop();
                },
              )

            ],
          );
        }
    );
  }
}