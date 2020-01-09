import 'package:dots_indicator/dots_indicator.dart';
import 'package:eit_app/screens/active_listening/active_list.dart';
import 'package:eit_app/screens/widgets/bottomnavbar.dart';
import 'package:eit_app/utils/project_db.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ActiveListenDetail extends StatefulWidget{
  static const routeName = '/listen_detail';
  @override
  State<StatefulWidget> createState() {
    return _ActiveListenDetailState();
  }
}

class _ActiveListenDetailState extends State<ActiveListenDetail>{
  PageController _pageController = PageController();
  int _pageIndex = 0;
  bool _editMode = false;
  TextEditingController _insights = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final _id = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color:Colors.grey,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushNamed(context, ActiveListenList.routeName),
        ),
      ),
      floatingActionButton: _detailModeButton(),
      bottomNavigationBar: _bottomNavBar(),
      body: _buildActiveListenDetail(context, _id),
    );
  }

  StreamBuilder<ListenRecord> _buildActiveListenDetail(BuildContext context, int id){
    final daoListen = Provider.of<ListenDao>(context);
    return StreamBuilder(
      stream: daoListen.watchListenEntry(id),
      builder: (context, AsyncSnapshot<ListenRecord> snapshot){
        final activity = snapshot.data ?? ListenRecord();
        if (!snapshot.hasData){
          return Center(child: Text("No data yet"),);
        }
        if (_editMode){
          return PageView(
            scrollDirection: Axis.horizontal,
            onPageChanged: (value){
              setState(() {
                _pageIndex = value;
              });
            },
            controller:_pageController,
            children: <Widget>[
              _inputField(context,activity,_insightsField(activity.detail,daoListen),'Insights'),
              _inputField(context,activity,_printChecklist(activity.desc,daoListen,_iHad,0),'I had ...'),
              _inputField(context,activity,_printChecklist(activity.desc,daoListen,_iGave,4),'I gave ...'),
              _inputField(context,activity,_printChecklist(activity.desc,daoListen,_iCan,7),'I can ...'),
              _inputField(context,activity,_printChecklist(activity.desc,daoListen,_iDidNot,9),'I did not ...'),
            ],
          );
        }else {
          return Padding(
            padding: EdgeInsets.only(right: 40, left: 40, bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  activity.detail.actName,
                  style: TextStyle(
                      fontFamily: 'Raleway',
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue[700]
                  ),
                ),
                Text(
                  DateFormat('M d, y hh:mm a').format(
                      activity.detail.dateCreated),
                  style: TextStyle(color: Colors.grey),
                ),
                Expanded(
                  child: Scrollbar(
                    child: ListView(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 15.0),
                          child: Text(activity.detail.insights,
                              style: TextStyle(fontSize: 16)),
                        ),
                        _section('I had: '),
                        Padding(
                          padding: EdgeInsets.only(top: 15.0),
                          child: _printChar(activity.desc, 0, 3),
                        ),
                        _section('I gave: '),
                        Padding(
                          padding: EdgeInsets.only(top: 15.0),
                          child: _printChar(activity.desc, 4, 6),
                        ),
                        _section('I can: '),
                        Padding(
                            padding: EdgeInsets.only(top: 15.0),
                            child: _printChar(activity.desc, 7, 8)
                        ),
                        _section('I did not: '),
                        Padding(
                          padding: EdgeInsets.only(top: 15.0),
                          child: _printChar(activity.desc, 9, 11),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  _section(String str){
    return Padding(
      padding: EdgeInsets.only(top:20),
      child: Text(
        str,
        style: TextStyle(
          fontSize: 16,
          color: Color(0xff21BEDE),
        ),
      ),
    );
  }

  _printChar(List<Desc> descs, int start, int end){
    final cleandesc = _cleanList(descs);
    List<String> _iHadOpt = [];
    for(int i = start; i <= end; i++){
      debugPrint('${i} => ${cleandesc[i].charVal}');
      if ((start == 0) && (cleandesc[i].charVal)){
          _iHadOpt.add(_iHad[i-start]);
      }else if ((start == 4) && (cleandesc[i].charVal)){
          _iHadOpt.add(_iGave[i-start]);
      }else if ((start == 7) && (cleandesc[i].charVal)){
        _iHadOpt.add(_iCan[i-start]);
      }else if ((start == 9) && (cleandesc[i].charVal)){
        _iHadOpt.add(_iDidNot[i-start]);
      }
    }
    return ListView.builder(
        shrinkWrap:true,
        itemCount: _iHadOpt.length,
        itemBuilder: (BuildContext context,index){
          return Padding(
              padding:EdgeInsets.only(top:5.0,bottom: 5.0, left:10.0),
              child: Text(_iHadOpt[index], style: TextStyle(fontSize: 15.0),)
          );
        }
    );
  }

  _cleanList(_list) {
    for ( int ctr = 0; ctr < _list.length; ctr++ ) {
      if ( _list[ctr] == null ) {
        _list.remove(_list[ctr]);
      }
    }
    return _list;
  }

  _inputField(BuildContext context, ListenRecord activity, field, String str){
    final dao = Provider.of<ListenDao>(context);
    return SingleChildScrollView(
      padding: EdgeInsets.only(left:40, right:40, bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _titleField(activity.detail,dao),
          _header(str),
          field,
        ],
      ),
    );
  }

  _insightsField(Listen activity, ListenDao dao){
    //_insights.text = activity.insights;
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter some text';
        } else {
          return null;
        }
      },
      initialValue: activity.insights,
      maxLines: null,
        decoration: InputDecoration(
        hintText: 'Consider the what, who, when, where, why and how.',
        hintMaxLines: 10,
        border: InputBorder.none,
      ),
      onChanged: (value) => ( value.isNotEmpty) ?  dao.updateListenActivity(activity.copyWith(insights: value)) : null,
      ),
    );
  }

  _titleField(Listen activity, ListenDao dao){
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: TextFormField(
        validator: (value){
          if (value.isEmpty){
            return 'Pleae enter some text';
          } else {
            return null;
          }
        },
        style:TextStyle(
          fontFamily: 'Raleway',
          fontSize: 30,
          fontWeight: FontWeight.w500,
          color: Colors.blue[700],
        ),
        initialValue: activity.actName,
        maxLines:null,
        decoration: InputDecoration(
          hintText: 'Enter Activity Name',
          hintStyle: TextStyle(fontSize: 20),
          border: InputBorder.none,
        ),
        onChanged: (value) => (value.isNotEmpty) ? dao.updateListenActivity(activity.copyWith(actName:value)) : null,
      ),
    );
  }

  _header(String str){
    return Text(
      str,
      style: TextStyle(
          fontFamily: 'Raleway',
          fontSize: 24,
          fontWeight: FontWeight.w300,
          color: Colors.blue[700]
      ),
    );
  }

  _printChecklist(List<Desc> descs, ListenDao dao, List<String> printdesc, int start){
    final cleandesc = _cleanList(descs);
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: printdesc.length,
        itemBuilder: (BuildContext context, int index){
          int _newindex = start + index;
          return Container(
            child: Column(
              children: <Widget>[
                CheckboxListTile(
                  value:cleandesc[_newindex].charVal,
                  title: Text(printdesc[index]),
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (value) => dao.updateDesc(descs[_newindex].copyWith(charVal: value))
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  _detailModeButton(){
    return FloatingActionButton(
        child: (_editMode) ? Icon(Icons.remove_red_eye) : Icon(Icons.edit),
        onPressed:(){
          setState(() {
            _editMode = !_editMode;
          });
        }
    );
  }

  _bottomNavBar() {
    return (_editMode) ? BottomAppBar(
      elevation: 0,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _pageNavigation(_pageIndex),
          bottomNavBar(context),
        ],
      ),
    ) : bottomNavBar(context);
  }

  _pageNavigation(int currpage){
    int _next;
    int _back;
    if (currpage == 0){
      _back = 4;
      _next = currpage + 1;
    } else if (currpage == 4){
      _back = currpage - 1;
      _next = 0;
    } else {
      _back = currpage - 1;
      _next = currpage + 1;
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
          DotsIndicator(
            dotsCount: 5,
            position: currpage.toDouble(),
          ),
          IconButton(
            icon: Icon(Icons.navigate_next),
            onPressed: () => _pageController.jumpToPage(_next),
          )
        ],
      ),
    );
  }
}

const List<String> _iHad = [
  'Postures and gestures that showed engagement',
  'Appropriate facial expression',
  'Appropriate eye contact',
  'Paraphrased what they said to check if I understood'
];
const List<String> _iGave = [
  'Minimal verbal encouragers',
  'Infrequet timely and considered questions',
  'Attentive Silences'
];
const List<String> _iCan = [
  'Pickup the speaker\'s feelings',
  'Summarize the speaker\'s major issues or points'
];
const List<String> _iDidNot = [
  'Judge, criticize, label, diagnose, or give praise evaluation',
  'Avoid their concern',
  'Moralize or advise'
];
