import 'package:eit_app/themes/apptheme.dart';
import 'package:eit_app/utils/project_db.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';


class JournalDetailViewMode extends StatelessWidget {
  final int id;

  JournalDetailViewMode({this.id});

  @override
  Widget build(BuildContext context) {
    JournalDao dao = Provider.of<JournalDao>(context);
    return StreamBuilder(
      stream: dao.watchJournalEntry(id),
      builder: (context, AsyncSnapshot<Journal> snapshot) {
        if ( !snapshot.hasData ){
          return Image(
            image: AssetImage('lib/assets/images/data/loading.png'),
            height: 300,
          );
        }
        final Journal record = snapshot.data;
        return Padding(
          padding: EdgeInsets.all(10.0),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverList(delegate: SliverChildListDelegate([
                Text(record.title ?? "", style: Theme.of(context).textTheme.display1.copyWith(color: MyBlue.light),),
                Text(DateFormat('MMMM d, y hh:mm a').format(record.dateCreated) ?? "", style: Theme.of(context).textTheme.subhead.copyWith(color: Colors.grey),),
                Text(record.description ?? "", textAlign: TextAlign.justify, style: Theme.of(context).textTheme.body1,),
                Text(record.feelings ?? "", textAlign: TextAlign.justify, style: Theme.of(context).textTheme.body1,),
                Text(record.evaluation ?? "", textAlign: TextAlign.justify, style: Theme.of(context).textTheme.body1,),
                Text(record.analysis ?? "", textAlign: TextAlign.justify, style: Theme.of(context).textTheme.body1,),
                Text(record.conclusion ?? "", textAlign: TextAlign.justify, style: Theme.of(context).textTheme.body1,),
                Text(record.analysis ?? "", textAlign: TextAlign.justify, style: Theme.of(context).textTheme.body1,),
              ]),)
            ],
          ),
        );
      },
    );
  }

}