import 'package:maintein/themes/apptheme.dart';
import 'package:maintein/utils/const_list_and_enum.dart';
import 'package:maintein/utils/project_db.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';


class ActiveListeningViewMode extends StatelessWidget {
  final id;
  ActiveListeningViewMode({this.id});
  @override
  Widget build(BuildContext context) {
    ListenDao dao = Provider.of<ListenDao>(context);
    return StreamBuilder(
      stream: dao.watchListenEntry(id),
      builder: (context, AsyncSnapshot<ListenRecord> snapshot) {
        if ( !snapshot.hasData ){
          return Image(
            image: AssetImage('lib/assets/images/data/loading.png'),
            height: 300,
          );
        }
        final ListenRecord record = snapshot.data ?? ListenRecord();
        List<Desc> characteristics = record.desc ?? List<Desc>();
        characteristics.removeWhere((characteristic) => characteristic == null);
        int _iHadCharacteristics = characteristics.sublist(0,3).where((c) => c.charVal == true).length;
        int _iGaveCharacteristics = characteristics.sublist(4,6).where((c) => c.charVal == true).length;
        int _iCanCharacteristics = characteristics.sublist(7,8).where((c) => c.charVal == true).length;
        int _iDidNotCharacteristics = characteristics.sublist(9,11).where((c) => c.charVal == true).length;
        return Padding(
          padding: EdgeInsets.all(10.0),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverList(delegate: SliverChildListDelegate([
                Text(record.detail.actName, style: Theme.of(context).textTheme.display1.copyWith(color: MyBlue.light),),
                Text(DateFormat('MMMM d, y hh:mm a').format(record.detail.dateCreated), style: Theme.of(context).textTheme.subhead.copyWith(color: Colors.grey),),
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(record.detail.insights, style: Theme.of(context).textTheme.body1,),
                ),
                (_iHadCharacteristics > 0 ) ? Text('I had ...', style: Theme.of(context).textTheme.title.copyWith(color: MyBlue.seagull),) : SliverList(delegate: SliverChildListDelegate([Container()]),),
              ]),),
              SliverList(delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                if ( characteristics[index].charVal ){
                  return Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(iHad[index], style: Theme.of(context).textTheme.body1,),
                  );
                } else {
                  return Container();
                }
              },
              childCount: 4,),),
              (_iGaveCharacteristics > 0 ) ? SliverList(delegate: SliverChildListDelegate([Text('I gave ...', style: Theme.of(context).textTheme.title.copyWith(color: MyBlue.seagull),),]),) : SliverList(delegate: SliverChildListDelegate([Container()]),),
              SliverList(delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                if ( characteristics[index+4].charVal ){
                  return Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(iHad[index], style: Theme.of(context).textTheme.body1,),
                  );
                } else {
                  return Container();
                }
              },
              childCount: 3,),),
              (_iCanCharacteristics > 0 ) ? SliverList(delegate: SliverChildListDelegate([Text('I can ...', style: Theme.of(context).textTheme.title.copyWith(color: MyBlue.seagull),),]),) : SliverList(delegate: SliverChildListDelegate([Container()]),),
              SliverList(delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                if ( characteristics[index+7].charVal ){
                  return Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(iHad[index], style: Theme.of(context).textTheme.body1,),
                  );
                } else {
                  return Container();
                }
              },
                childCount: 2,),),
              (_iDidNotCharacteristics > 0 ) ? SliverList(delegate: SliverChildListDelegate([Text('I  did not ...', style: Theme.of(context).textTheme.title.copyWith(color: MyBlue.seagull),),]),) : SliverList(delegate: SliverChildListDelegate([Container()]),),
              SliverList(delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                if ( characteristics[index+9].charVal ){
                  return Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(iHad[index], style: Theme.of(context).textTheme.body1,),
                  );
                } else {
                  return Container();
                }
              },
                childCount: 3,),),
            ],
          ),
        );
      },
    );
  }

}