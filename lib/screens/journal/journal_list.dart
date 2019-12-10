import 'package:eit_app/screens/journal/journal_detail.dart';
import 'package:eit_app/screens/journal/journal_new.dart';
import 'package:eit_app/screens/widgets/bottomnavbar.dart';
import 'package:eit_app/utils/project_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';


class JournalList extends StatefulWidget {
  static const routeName = '/journal_list';

  @override
  State<StatefulWidget> createState() {
    return _JournalListState();
  }
}

class _JournalListState extends State<JournalList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Padding(
        padding: EdgeInsets.only(left: 40, right: 40, top: 40, bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _headline(),
            Expanded(child: _buildEntryList(context),),
          ],
        ),
      ),
      bottomNavigationBar: bottomNavBar(context),
      floatingActionButton: _addEntryButton(),
    );
  }
  Padding _headline() {
    return Padding(
      padding: EdgeInsets.only(top:40),
      child: Text(
        'Entries',
        style: TextStyle(
          fontFamily: 'Raleway',
          fontSize: 45,
          fontWeight: FontWeight.w500
        ),
      ),
    );
  }
  StreamBuilder<List<Journal>> _buildEntryList(BuildContext context) {
    final dao = Provider.of<JournalDao>(context);
    return StreamBuilder(
      stream: dao.watchJournalEntries(),
      builder: (context, AsyncSnapshot<List<Journal>> snapshot) {
        final entries = snapshot.data ?? List();
        return ListView.builder(
          itemCount: entries.length,
          itemBuilder: (_, index) {
            final entry = entries[index];
            return _buildEntryItem(entry, dao);
          },
        );
      },
    );
  }
  Widget _buildEntryItem(Journal entry, JournalDao dao) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          icon: Icons.delete,
          onTap: () => dao.deleteJournalEntry(entry),
        )
      ],
      child: Card(
        color: Colors.white,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              JournalDetail.routeName,
              arguments: entry.id
            );
          },
          child: Padding(
            padding: EdgeInsets.only(right: 20, bottom: 10, top: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 100,
                  child: Column(
                    children: <Widget>[
                      Text(
                        DateFormat('MMM').format(entry.dateCreated),
                        style: TextStyle(
                            color: Color(0xff21BEDE),
                            fontSize: 18
                        ),
                      ),
                      Text(
                        DateFormat('dd').format(entry.dateCreated),
                        style: TextStyle(
                          color: Color(0xff21BEDE),
                          fontSize: 30,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          entry.title,
                          style: TextStyle(
                              fontFamily: 'Raleway',
                              fontSize: 20,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Text(
                          DateFormat('hh:mm a').format(entry.dateCreated),
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Text(
                        entry.description,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            color: Colors.grey
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
  FloatingActionButton _addEntryButton() {
    return FloatingActionButton(
      backgroundColor: Color(0xff21BEDE),
      onPressed: () => Navigator.pushNamed(context, JournalNewForm.routeName),
      tooltip: 'Add journal entry',
      child: Icon(Icons.add),
    );
  }
}