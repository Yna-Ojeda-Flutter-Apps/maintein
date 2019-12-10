import 'package:dots_indicator/dots_indicator.dart';
import 'package:eit_app/screens/active_listening/active_list.dart';
import 'package:eit_app/screens/widgets/bottomnavbar.dart';
import 'package:eit_app/utils/project_db.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:moor/moor.dart' as moorPackage;

class ActiveListenNewForm extends StatefulWidget{
  static const routeName = '/listen_new';
  @override
  State<StatefulWidget> createState() {
    return _ActiveListenNewState();
  }
}

class _ActiveListenNewState extends State<ActiveListenNewForm>{
  PageController _pageController = PageController();
  int _pageIndex = 0;
  TextEditingController _actName = TextEditingController();
  TextEditingController _insights = TextEditingController();

  List<String> _iHad = ['Postures and gestures that showed engagement', 'Appropriate facial expression', 'Appropriate eye contact', 'Paraphrased what they said to check if I understood'];
  List<String> _iGave = ['Minimal verbal encouragers','Infrequent timely and considered questions','Attentive Silences'];
  List<String> _iCan = ['Pickup the speaker\'s feelings','Summarize the speaker\'s major issues or points'];
  List<String> _iDidNot = ['Judge, criticize, label, diagnose, or give praise evaluation','Avoid their concern','Moralize or advise'];
  List<bool> _iHadbool =  [false,false,false,false];
  List<bool> _iGavebool = [false,false,false];
  List<bool> _iCanbool = [false,false];
  List<bool> _iDidbool = [false,false,false];
  @override
  Widget build(BuildContext context) {
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
          onPressed: (){
            Navigator.pushNamed(context, ActiveListenList.routeName);
          },
        ),
      ),
      floatingActionButton: _saveFormButton(),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color:Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _pageNavigation(_pageIndex),
            bottomNavBar(context),
          ],
        ),
      ),
    body: PageView(
      scrollDirection: Axis.horizontal,
      controller: _pageController,
      children:<Widget>[
        _inputField(context, _insightsField(), "Insights"),
        _inputField(context, _iHadChecklist(), "I had ..."),
        _inputField(context, _iGaveChecklist(), "I gave ..."),
        _inputField(context, _iCanChecklist(), "l can ..."),
        _inputField(context, _iDidNotChecklist(), "I did not ..."),
      ],
      onPageChanged: (value){
        setState(() {
          _pageIndex = value;
        });
      },
      ),
    );
  }

  _inputField(BuildContext context, field, String str){
    return SingleChildScrollView(
      padding: EdgeInsets.only(left: 40, right: 40, bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _actNameField(),
          _headerText(str),
          field,
        ],
      ),
    );
  }

  _actNameField(){
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: TextFormField(
        validator: (value){
          if (value.isEmpty){
            return 'Please enter some text';
          } else {
            return null;
          }
        },
        style: TextStyle(
          fontFamily: 'Raleway',
          fontSize: 30,
          fontWeight: FontWeight.w500,
          color: Colors.blue[700],
        ),
        controller: _actName,
        maxLines: null,
        decoration: InputDecoration(
          hintText: 'Enter Activity Name',
          hintStyle: TextStyle(fontSize: 20),
          border: InputBorder.none,
        ),
      ),
    );
  }

  _headerText(String str){
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

  _insightsField(){
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: TextFormField(
        validator: (value){
          if (value.isEmpty){
            return "Please enter some text";
          } else {
            return null;
          }
        },
        controller: _insights,
        maxLines: null,
        decoration: InputDecoration(
          hintText: "Summary of what you've learned",
          hintMaxLines: 10,
          border: InputBorder.none,
        ),
      ),
    );
  }

  _iHadChecklist(){
    return Padding(
      padding:EdgeInsets.only(bottom: 10),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount:_iHad.length,
          itemBuilder: (BuildContext context, int index){
            return Container(
              child: Column(
                children: <Widget>[
                  CheckboxListTile(
                    value:_iHadbool[index],
                    title: Text(_iHad[index]),
                    controlAffinity:ListTileControlAffinity.leading,
                    onChanged: (bool val){
                      setState((){
                        _iHadbool[index] = val;
                      });
                    },
                  )
                ],
              ),
            );
          }
        ),
      );
  }

  _iGaveChecklist(){
    return Padding(
      padding:EdgeInsets.only(bottom: 10),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount:_iGave.length,
          itemBuilder: (BuildContext context, int index){
            return Container(
              child: Column(
                children: <Widget>[
                  CheckboxListTile(
                    value:_iGavebool[index],
                    title: Text(_iGave[index]),
                    controlAffinity:ListTileControlAffinity.leading,
                    onChanged: (bool val){
                      setState((){
                        _iGavebool[index] = val;
                      });
                    },
                  )
                ],
              ),
            );
          }
      ),
    );
  }

  _iCanChecklist(){
    return Padding(
      padding:EdgeInsets.only(bottom: 10),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount:_iCan.length,
          itemBuilder: (BuildContext context, int index){
            return Container(
              child: Column(
                children: <Widget>[
                  CheckboxListTile(
                    value:_iCanbool[index],
                    title: Text(_iCan[index]),
                    controlAffinity:ListTileControlAffinity.leading,
                    onChanged: (bool val){
                      setState((){
                        _iCanbool[index] = val;
                      });
                    },
                  )
                ],
              ),
            );
          }
      ),
    );
  }

  _iDidNotChecklist(){
    return Padding(
      padding:EdgeInsets.only(bottom: 10),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount:_iDidNot.length,
          itemBuilder: (BuildContext context, int index){
            return Container(
              child: Column(
                children: <Widget>[
                  CheckboxListTile(
                    value:_iDidbool[index],
                    title: Text(_iDidNot[index]),
                    controlAffinity:ListTileControlAffinity.leading,
                    onChanged: (bool val){
                      setState((){
                        _iDidbool[index] = val;
                      });
                    },
                  )
                ],
              ),
            );
          }
      ),
    );
  }

  _validateAllForms(){
    return (_insights.text.isNotEmpty && _actName.text.isNotEmpty);
  }

  _resetFields(){
    setState(() {
      _insights.clear();
      _actName.clear();
      //_iHadbool = [false,false,false,false];
      //_iGavebool = [false,false,false];
      //_iCanbool = [false,false];
      //_iDidbool = [false,false,false];
    });
    Navigator.pushNamed(context, ActiveListenList.routeName);
  }

  _saveFormButton(){
    return FloatingActionButton(
      child: const Icon(Icons.done,),
      onPressed: (  _validateAllForms() ) ? () {
        final dao = Provider.of<ListenDao>(context);
        final activity = ListensCompanion(
          actName: moorPackage.Value(_actName.text),
          dateCreated: moorPackage.Value(DateTime.now()),
          insights: moorPackage.Value(_insights.text),
          iHad1 : moorPackage.Value(_iHadbool[0]),
          iHad2 : moorPackage.Value(_iHadbool[1]),
          iHad3 : moorPackage.Value(_iHadbool[2]),
          iHad4 : moorPackage.Value(_iHadbool[3]),
          iGave1: moorPackage.Value(_iGavebool[0]),
          iGave2: moorPackage.Value(_iGavebool[1]),
          iGave3: moorPackage.Value(_iGavebool[2]),
          iCan1: moorPackage.Value(_iCanbool[0]),
          iCan2: moorPackage.Value(_iCanbool[1]),
          ididNot1: moorPackage.Value(_iDidbool[0]),
          ididNot2: moorPackage.Value(_iDidbool[1]),
          ididNot3: moorPackage.Value(_iDidbool[2]),
      );
      dao.insertListenActivity(activity);
      setState(() {
        _resetFields();
        _pageIndex = 0;
        });
      } : null,
    );

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