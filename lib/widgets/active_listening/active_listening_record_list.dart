import 'package:eit_app/screens/active_listening/active_detail.dart';
import 'package:eit_app/themes/apptheme.dart';
import 'package:eit_app/utils/const_list_and_enum.dart';
import 'package:eit_app/utils/list_filters.dart';
import 'package:eit_app/utils/project_db.dart';
import 'package:eit_app/widgets/my_slidable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';


class ActiveListeningRecordList extends StatefulWidget {
  final DateFilter currentFilter;

  ActiveListeningRecordList({this.currentFilter});

  @override
  State<StatefulWidget> createState() => _ActiveListeningRecordListState();

}

class _ActiveListeningRecordListState extends State<ActiveListeningRecordList>{
  @override
  Widget build(BuildContext context) {
    final dao = Provider.of<ListenDao>(context);
    return StreamBuilder(
      stream: dao.watchAll(),
      builder: (context, AsyncSnapshot<List<Listen>> snapshot) {
        if ( !snapshot.hasData ) {
          return SliverList(delegate: SliverChildListDelegate([Image(
            image: AssetImage('lib/assets/images/data/loading.png'),
            height: 300,
          )]),);
        }
        List<Listen> records = snapshot.data ?? List<Listen>();
        records = filterListenRecords(records, widget.currentFilter);
        if ( records.length < 1 ) {
          return SliverList(delegate: SliverChildListDelegate([Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage('lib/assets/images/data/converse.png'),
                height: 300,
              ),
              Text("Let's listen to somebody and add entries.", style: Theme.of(context).textTheme.subhead.copyWith(color: Colors.grey[600]),),
            ],
          )]),);
        }
        return SliverList(
          delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
            return MySlidable(
              onTap: () => _confirmDelete(context, records[index], dao),
              child: Card(
                color: Colors.white,
                elevation: 3.0,
                child: InkWell(
                  onTap: () => Navigator.pushNamed(context, ActiveListenDetail.routeName, arguments: records[index].id),
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
                                child:Text(records[index].actName ?? "", style: Theme.of(context).textTheme.subhead,),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 5),
                                child: Text(
                                  DateFormat('hh:mm a').format(records[index].dateCreated), style: Theme.of(context).textTheme.subtitle, textAlign: TextAlign.left,),
                              ),
                              Text(
                                "You exhibited ${records[index].descriptionCount} characteristic(s) of active listening.",
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
      }
    );
  }

  void _confirmDelete(BuildContext context, Listen listen, ListenDao dao) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
            title: Text("Delete '"+listen.actName+"'?"),
            content: Text("Deleting this entry cannot be undone."),
            actions: <Widget>[
              FlatButton(child: Text('Cancel'), onPressed: () => Navigator.of(context).pop(),),
              FlatButton(
                child: Text('Delete', style: TextStyle(color: Colors.redAccent),),
                onPressed: () async {
                  dao.deleteListenActivity(listen);
                  Navigator.of(context).pop();
                },
              )

            ],
          );
        }
    );
  }
}