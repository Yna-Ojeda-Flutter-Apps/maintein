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
  List<String> _iHad = ['Postures and gestures that showed engagement', 'Appropriate facial expression', 'Appropriate eye contact', 'Paraphrased what they said to check if I understood'];
  List<String> _iGave = ['Minimal verbal encouragers','Infrequent timely and considered questions','Attentive Silences'];
  List<String> _iCan = ['Pickup the speaker\'s feelings','Summarize the speaker\'s major issues or points'];
  List<String> _iDidNot = ['Judge, criticize, label, diagnose, or give praise evaluation','Avoid their concern','Moralize or advise'];
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
          icon:Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushNamed(context, ActiveListenList.routeName),
        ),
      ),
      floatingActionButton: _detailModeButton(),
      bottomNavigationBar: _bottomNavBar(),
      body: _buildActiveListenDetail(context, _id),
    );
  }

  StreamBuilder<Listen> _buildActiveListenDetail(BuildContext context, int id){
    final dao = Provider.of<ListenDao>(context);
    return StreamBuilder(
      stream: dao.watchListenEntry(id),
      builder: (context, AsyncSnapshot<Listen> snapshot){
        final activity = snapshot.data;
        if (!snapshot.hasData){
          return Center(child: Text("No data yet"),);
        }
        if(_editMode){
          return PageView(
            scrollDirection: Axis.horizontal,
            onPageChanged:(value){
              setState(() {
                _pageIndex = value;
              });
            },
            controller:_pageController,
            children: <Widget>[
              _inputField(context,activity,_insightsField(activity,dao),'Insights'),
              _inputField(context,activity,_iHadChecklist(activity,dao),'I had ...'),
              _inputField(context,activity,_iGaveChecklist(activity,dao),'I gave ...'),
              _inputField(context,activity,_iCanChecklist(activity,dao), 'I can ...'),
              _inputField(context,activity,_iDidNotChecklist(activity,dao), 'I did not ...'),
            ],
          );
        }else{
          return Padding(
            padding: EdgeInsets.only(right: 40, left: 40, bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  activity.actName,
                  style: TextStyle(
                      fontFamily: 'Raleway',
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue[700]
                  ),
                ),
                Text(
                  DateFormat('M d, y hh:mm a').format(activity.dateCreated),
                  style: TextStyle(color: Colors.grey),
                ),
                Expanded(
                  child:Scrollbar(
                    child:ListView(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top:15.0),
                          child: Text(activity.insights, style:TextStyle(fontSize: 16)),
                        ),
                        _section('I had:'),
                        Padding(
                          padding:EdgeInsets.only(top:15.0),
                          child:iHadPrint(activity),
                        ),
                        _section('I gave:'),
                        Padding(
                          padding:EdgeInsets.only(top:15.0),
                          child:iGavePrint(activity),
                        ),
                        _section('I can:'),
                        Padding(
                          padding:EdgeInsets.only(top:15.0),
                          child:iCanPrint(activity),
                        ),
                        _section('I did not:'),
                        Padding(
                          padding:EdgeInsets.only(top:15.0),
                          child:iDidNotPrint(activity),
                        ),
                      ],
                    ),
                  ) ,
                ),
              ],
            ),
          );
        }
      }
    );
  }

  iHadPrint(Listen activity){
    List<String> _iHadopt = [];
    if (activity.iHad1){_iHadopt.add(_iHad[0]);}
    if (activity.iHad2){_iHadopt.add(_iHad[1]);}
    if (activity.iHad3){_iHadopt.add(_iHad[2]);}
    if (activity.iHad4){_iHadopt.add(_iHad[3]);}

    return ListView.builder(
        shrinkWrap:true,
        itemCount: _iHadopt.length,
        itemBuilder: (BuildContext context,index){
          return Padding(
            padding:EdgeInsets.only(top:5.0,bottom: 5.0, left:10.0),
            child: Text(_iHadopt[index], style: TextStyle(fontSize: 15.0),)
          );
        }
    );
  }

  iGavePrint(Listen activity){
    List<String> _iGaveopt = [];
    if (activity.iGave1){_iGaveopt.add(_iGave[0]);}
    if (activity.iGave2){_iGaveopt.add(_iGave[1]);}
    if (activity.iGave3){_iGaveopt.add(_iGave[2]);}
    return ListView.builder(
        shrinkWrap:true,
        itemCount: _iGaveopt.length,
        itemBuilder: (BuildContext context,index){
          return Padding(
              padding:EdgeInsets.only(top:5.0,bottom: 5.0, left:10.0),
              child: Text(_iGaveopt[index], style: TextStyle(fontSize: 15.0),)
          );
        }
    );
  }

  iCanPrint(Listen activity){
    List<String> _iCanopt = [];
    if (activity.iCan1){_iCanopt.add(_iCan[0]);}
    if (activity.iCan2){_iCanopt.add(_iCan[1]);}
    return ListView.builder(
        shrinkWrap:true,
        itemCount: _iCanopt.length,
        itemBuilder: (BuildContext context,index){
          return Padding(
              padding:EdgeInsets.only(top:5.0,bottom: 5.0, left:10.0),
              child: Text(_iCanopt[index], style: TextStyle(fontSize: 15.0),)
          );
        }
    );
  }

  iDidNotPrint(Listen activity){
    List<String> _iDidopt = [];
    if (activity.ididNot1){_iDidopt.add(_iDidNot[0]);}
    if (activity.ididNot2){_iDidopt.add(_iDidNot[1]);}
    if (activity.ididNot3){_iDidopt.add(_iDidNot[2]);}
    return ListView.builder(
        shrinkWrap:true,
        itemCount: _iDidopt.length,
        itemBuilder: (BuildContext context,index){
          return Padding(
              padding:EdgeInsets.only(top:5.0,bottom: 5.0, left:10.0),
              child: Text(_iDidopt[index], style: TextStyle(fontSize: 15.0),)
          );
        }
    );
  }

  _inputField(BuildContext context, Listen activity, field, String str){
    final dao = Provider.of<ListenDao>(context);
    return SingleChildScrollView(
      padding: EdgeInsets.only(left: 40, right: 40, bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _titleField(activity, dao),
          _header(str),
          field,
        ],
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

  _section(String str) {
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

  _insightsField(Listen activity, ListenDao dao){
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

  _iHadChecklist(Listen activity, ListenDao dao){
    return Padding(
      padding:EdgeInsets.only(bottom: 10),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount:_iHad.length,
          itemBuilder: (BuildContext context, int index){
            final hadChar = _iHad[index];
            return _buildHadChar(activity,index,hadChar,dao);
          }
      ),
    );
  }

  _buildHadChar(Listen activity, int index, String str, ListenDao dao){
    if (index == 0){
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: 10),
            child:Checkbox(
              value: activity.iHad1,
              onChanged: (value) => dao.updateListenActivity(activity.copyWith(iHad1: value)),
            ),
          ),
          Expanded(
            child: Text(str),
          ),
        ],
      );
    } else if (index == 1){
       return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 10),
              child:Checkbox(
                value: activity.iHad2,
                onChanged: (value) => dao.updateListenActivity(activity.copyWith(iHad2: value)),
              ),
            ),
            Expanded(
              child: Text(str),
            ),
          ],
        );
    } else if (index == 2){
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 10),
              child:Checkbox(
                value: activity.iHad3,
                onChanged: (value) => dao.updateListenActivity(activity.copyWith(iHad3: value)),
              ),
           ),
            Expanded(
              child: Text(str),
           ),
          ],
        );
    } else if (index == 3){
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 10),
              child:Checkbox(
                value: activity.iHad4,
                onChanged: (value) => dao.updateListenActivity(activity.copyWith(iHad4: value)),
              ),
            ),
            Expanded(
              child: Text(str),
            ),
          ],
        );
    }
  }

  _iGaveChecklist(Listen activity, ListenDao dao){
    return Padding(
      padding:EdgeInsets.only(bottom: 10),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount:_iGave.length,
          itemBuilder: (BuildContext context, int index){
            final gaveChar = _iGave[index];
            return _buildGaveChar(activity,index,gaveChar,dao);
          }
      ),
    );
  }

  _buildGaveChar(Listen activity, int index, String str, ListenDao dao){
    if (index == 0){
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: 10),
            child:Checkbox(
              value: activity.iGave1,
              onChanged: (value) => dao.updateListenActivity(activity.copyWith(iGave1: value)),
            ),
          ),
          Expanded(
            child: Text(str),
          ),
        ],
      );
    } else if (index == 1){
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: 10),
            child:Checkbox(
              value: activity.iGave2,
              onChanged: (value) => dao.updateListenActivity(activity.copyWith(iGave2: value)),
            ),
          ),
          Expanded(
            child: Text(str),
          ),
        ],
      );
    } else if (index == 2){
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: 10),
            child:Checkbox(
              value: activity.iGave3,
              onChanged: (value) => dao.updateListenActivity(activity.copyWith(iGave3: value)),
            ),
          ),
          Expanded(
            child: Text(str),
          ),
        ],
      );
    }
  }

  _iCanChecklist(Listen activity, ListenDao dao){
    return Padding(
      padding:EdgeInsets.only(bottom: 10),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount:_iCan.length,
          itemBuilder: (BuildContext context, int index){
            final canChar = _iCan[index];
            return _buildCanChar(activity,index,canChar,dao);
          }
      ),
    );
  }

  _buildCanChar(Listen activity, int index, String str, ListenDao dao){
    if (index == 0){
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: 10),
            child:Checkbox(
              value: activity.iCan1,
              onChanged: (value) => dao.updateListenActivity(activity.copyWith(iCan1: value)),
            ),
          ),
          Expanded(
            child: Text(str),
          ),
        ],
      );
    } else if (index == 1){
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: 10),
            child:Checkbox(
              value: activity.iCan2,
              onChanged: (value) => dao.updateListenActivity(activity.copyWith(iCan2: value)),
            ),
          ),
          Expanded(
            child: Text(str),
          ),
        ],
      );
    }
  }

  _iDidNotChecklist(Listen activity, ListenDao dao){
    return Padding(
      padding:EdgeInsets.only(bottom: 10),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount:_iDidNot.length,
          itemBuilder: (BuildContext context, int index){
            final didNotChar = _iDidNot[index];
            return _buildDidChar(activity,index,didNotChar,dao);
          }
      ),
    );
  }

   _buildDidChar(Listen activity, int index, String str, ListenDao dao){
    if (index == 0){
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: 10),
            child:Checkbox(
              value: activity.ididNot1,
              onChanged: (value) => dao.updateListenActivity(activity.copyWith(ididNot1: value)),
            ),
          ),
          Expanded(
            child: Text(str),
          ),
        ],
      );
    } else if (index == 1){
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: 10),
            child:Checkbox(
              value: activity.ididNot2,
              onChanged: (value) => dao.updateListenActivity(activity.copyWith(ididNot2: value)),
            ),
          ),
          Expanded(
            child: Text(str),
          ),
        ],
      );
    } else if (index == 2){
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: 10),
            child:Checkbox(
              value: activity.ididNot3,
              onChanged: (value) => dao.updateListenActivity(activity.copyWith(ididNot3: value)),
            ),
          ),
          Expanded(
            child: Text(str),
          ),
        ],
      );
    }
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