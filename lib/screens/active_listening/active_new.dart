import 'package:dots_indicator/dots_indicator.dart';
import 'package:maintein/utils/const_list_and_enum.dart';
import 'package:maintein/utils/project_db.dart';
import 'package:maintein/widgets/active_listening/active_listening_form.dart';
import 'package:maintein/widgets/bottomnavbar.dart';
import 'package:maintein/themes/apptheme.dart';
import 'package:maintein/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:moor/moor.dart' as moorPackage;
import 'package:provider/provider.dart';

class ActiveListenNewForm extends StatefulWidget{
  static const routeName = '/listen_new';
  @override
  State<StatefulWidget> createState() {
    return _ActiveListenNewFormState();
  }
}

class _ActiveListenNewFormState extends State<ActiveListenNewForm>{
  PageController _pageController = PageController();
  int _pageIndex = 0;
  String _actName;
  String _insights;
  List<bool> _characteristics = List<bool>.filled(12, false);
  List<String> _checkedIHad = [];
  List<String> _checkedIGave = [];
  List<String> _checkedICan = [];
  List<String> _checkedIDidNot = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      resizeToAvoidBottomPadding: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: MyAppBar(appBarBottom: _pageNavigation(_pageIndex),),
      ),
      floatingActionButton: _saveFormButton(),
      bottomNavigationBar: BottomNavBar(),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: PageView(
          scrollDirection: Axis.horizontal,
          controller: _pageController,
          children: <Widget>[
            ActiveListeningForm(
              titleInitialValue: _actName,
              titleOnChanged: (value) { setState(() { _actName = value; });},
              header: "Insights",
              isCheckboxList: false,
              textFieldOnChange: (value) { setState(() { _insights = value; });},
            ),
            ActiveListeningForm(
              titleInitialValue: _actName,
              titleOnChanged: (value) { setState(() { _actName = value; });},
              header: "I had . . .",
              isCheckboxList: true,
              checkListItems: iHad,
              checkListValues: _checkedIHad,
              checkboxOnChange: (bool isChecked, String label, int index) {
                setState(() {
                  _characteristics[index] = isChecked;
                  (isChecked) ? _checkedIHad.add(iHad[index]) : _checkedIHad.remove(iHad[index]);
                });
              },
            ),ActiveListeningForm(
              titleInitialValue: _actName,
              titleOnChanged: (value) { setState(() { _actName = value; });},
              header: "I gave . . .",
              isCheckboxList: true,
              checkListItems: iGave,
              checkListValues: _checkedIGave,
              checkboxOnChange: (bool isChecked, String label, int index) {
                setState(() {
                  _characteristics[index+4] = isChecked;
                  (isChecked) ? _checkedIGave.add(iGave[index]) : _checkedIGave.remove(iGave[index]);
                });
              },
            ),
            ActiveListeningForm(
              titleInitialValue: _actName,
              titleOnChanged: (value) { setState(() { _actName = value; });},
              header: "I can . . .",
              isCheckboxList: true,
              checkListItems: iCan,
              checkListValues: _checkedICan,
              checkboxOnChange: (bool isChecked, String label, int index) {
                setState(() {
                  _characteristics[index+7] = isChecked;
                  (isChecked) ? _checkedICan.add(iCan[index]) : _checkedICan.remove(iCan[index]);
                });
              },
            ),
            ActiveListeningForm(
              titleInitialValue: _actName,
              titleOnChanged: (value) { setState(() { _actName = value; });},
              header: "I did not . . .",
              isCheckboxList: true,
              checkListItems: iDidNot,
              checkListValues: _checkedIDidNot,
              checkboxOnChange: (bool isChecked, String label, int index) {
                setState(() {
                  _characteristics[index+9] = isChecked;
                  (isChecked) ? _checkedIDidNot.add(iDidNot[index]) : _checkedIDidNot.remove(iDidNot[index]);
                });
              },
            ),
          ],
          onPageChanged: (value){
            setState(() {
              _pageIndex = value;
            });
          },
        ),
      ),
    );
  }

  bool _validateAll() {
    _actName = _actName ?? "";
    _insights = _insights ?? "";
    return ( (_actName.length > 0) && (_insights.length > 0) && _characteristics.contains(true));
  }
  FloatingActionButton _saveFormButton() {
    return FloatingActionButton(
      tooltip: "Save Entry",
      backgroundColor: (_validateAll()) ? MyBlue.picton : Colors.grey,
      foregroundColor: Colors.white,
      child: const Icon(Icons.done),
      onPressed: () async {
        if ( _validateAll() ) {
          final dao = Provider.of<ListenDao>(context);
          var _count = 0;
          _characteristics.forEach((char) { if ( char ) { _count = _count + 1; } });
          final activity = ListensCompanion(
            actName: moorPackage.Value(_actName),
            dateCreated: moorPackage.Value(DateTime.now()),
            insights: moorPackage.Value(_insights),
            descriptionCount: moorPackage.Value(_count),
          );
          final activityId = await dao.insertListenActivity(activity);

          for (int i = 0; i<12; i++){
            var desc = DescsCompanion(
              id:moorPackage.Value(activityId),
              cId:moorPackage.Value(i),
              charVal: moorPackage.Value(_characteristics[i]),
            );
            dao.insertDesc(desc);
          }
          setState(() {
            _actName = "";
            _insights = "";
            _characteristics = List<bool>.filled(12, false);
            _pageIndex = 0;
            _checkedIHad = [];
            _checkedIGave = [];
            _checkedICan = [];
            _checkedIDidNot = [];
          });
          Navigator.of(context).pop();
          _newEntryFeedback(context, _count);
        }
      },
    );
  }

  void _newEntryFeedback(BuildContext context, int count) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
            title: Text((count < 7) ? "Nice job!" : "Great Listening!"),
            content: Text((count < 7) ? "You got "+count.toString()+" characteristics. Let's have more fun and improve more!" : "You got "+count.toString()+" characteristics. Keep up those excellent listening skills!"),
            actions: <Widget>[
              FlatButton(child: Text("Okay"), onPressed: () => Navigator.of(context).pop())
            ],
          );
        }
    );
  }

  _pageNavigation(int currentPage){
    int _next;
    int _back;
    if (currentPage == 0){
      _back = 4;
      _next = currentPage + 1;
    } else if (currentPage == 4){
      _back = currentPage - 1;
      _next = 0;
    } else {
      _back = currentPage - 1;
      _next = currentPage + 1;
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
            decorator: DotsDecorator(activeColor: MyBlue.seagull),
            position: currentPage.toDouble(),
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

