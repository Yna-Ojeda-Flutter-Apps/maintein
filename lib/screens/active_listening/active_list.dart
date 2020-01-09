import 'package:eit_app/screens/active_listening/active_detail.dart';
import 'package:eit_app/screens/active_listening/active_new.dart';
import 'package:eit_app/screens/widgets/bottomnavbar.dart';
import 'package:eit_app/utils/project_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ActiveListenList extends StatefulWidget{
  static const routeName = '/listen_list';

  @override
  State<StatefulWidget> createState() {
    return _ActiveListenListState();
  }
}

class _ActiveListenListState extends State<ActiveListenList>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Padding(
        padding: EdgeInsets.only(left:40, right: 40, top: 40, bottom: 10),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _headline(),
            Expanded(child: _buildActivityList(context),),
          ],
        ),
      ),
      bottomNavigationBar: bottomNavBar(context),
      floatingActionButton: _addActivityButton(),
    );
  }

  Padding _headline(){
    return Padding(
      padding:EdgeInsets.only(top:40),
      child: Text(
        'Listens to',
        style: TextStyle(
          fontFamily: 'Raleway',
          fontSize: 45,
          fontWeight: FontWeight.w500,
        ),
      )
    );
  }

  StreamBuilder<List<ListenRecord>> _buildActivityList(context){
    final dao = Provider.of<ListenDao>(context);
    return StreamBuilder(
      stream: dao.watchActiveListenEntries(),
      builder: (context, AsyncSnapshot<List<ListenRecord>> snapshot){
        final listens = snapshot.data ?? List();
        return ListView.builder(
          itemCount: listens.length,
          itemBuilder: (_, index){
            final listen = listens[index];
            return _buildActivityItem(listen, dao);
          },
        );
      },
    );
  }

  Widget _buildActivityItem(ListenRecord listen, ListenDao dao){
    return Slidable(
      actionPane:SlidableDrawerActionPane(),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          icon: Icons.delete,
          onTap: () =>  dao.deleteListenActivity(listen.detail),
        )
      ],
      child: Card(
        color: Colors.white,
        child: InkWell(
          onTap: (){
            Navigator.pushNamed(
              context,
              ActiveListenDetail.routeName,
              arguments: listen.detail.id
            );
          },
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
                            DateFormat('MMM').format(listen.detail.dateCreated),
                            style: TextStyle(
                              color:Color(0xff21BEDE),
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            DateFormat('dd').format(listen.detail.dateCreated),
                            style: TextStyle(
                              color:Color(0xff21BEDE),
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
                        child:Text(
                          listen.detail.actName,
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Text(
                          DateFormat('hh:mm a').format(listen.detail.dateCreated),
                          style: TextStyle(
                            color:Colors.grey,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Text(
                        listen.detail.insights,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: Colors.grey
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }

  FloatingActionButton _addActivityButton(){
    return FloatingActionButton(
      backgroundColor: Color(0xff21BEDE),
      onPressed: () => Navigator.pushNamed(context, ActiveListenNewForm.routeName),
      tooltip: 'Add Activity',
      child: Icon(Icons.add),
    );
  }
}