import 'package:dots_indicator/dots_indicator.dart';
import 'package:maintein/utils/const_list_and_enum.dart';
import 'package:maintein/widgets/active_listening/active_listening_edit_form.dart';
import 'package:maintein/widgets/active_listening/active_listening_view.dart';
import 'package:maintein/widgets/bottomnavbar.dart';
import 'package:maintein/themes/apptheme.dart';
import 'package:maintein/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    final _id = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: (_editMode) ? MyAppBar(appBarBottom: _pageNavigation(_pageIndex),) : AppBar(elevation: 0.0, automaticallyImplyLeading: false, backgroundColor: Colors.white,),
      ),
      floatingActionButton: _detailModeButton(),
      bottomNavigationBar: BottomNavBar(),
      body: (_editMode) ? Padding(
        padding: EdgeInsets.all(10.0),
        child: PageView(
          scrollDirection: Axis.horizontal,
          controller: _pageController,
          children: <Widget>[
            ActiveListeningEditForm(
              id: _id,
              header: "Insights",
              isCheckboxList: false,
            ),
            ActiveListeningEditForm(
              id: _id,
              header: "I had . . .",
              labels: iHad,
              characteristicIndices: [0,1,2,3],
              isCheckboxList: true,
            ),
            ActiveListeningEditForm(
              id: _id,
              header: "I gave . . .",
              labels: iGave,
              characteristicIndices: [4,5,6],
              isCheckboxList: true,
            ),
            ActiveListeningEditForm(
              id: _id,
              header: "I can . . .",
              labels: iCan,
              characteristicIndices: [7,8],
              isCheckboxList: true,
            ),
            ActiveListeningEditForm(
              id: _id,
              header: "I did not . . .",
              labels: iDidNot,
              characteristicIndices: [9,10,11],
              isCheckboxList: true,
            ),
          ],
          onPageChanged: (value){
            setState(() {
              _pageIndex = value;
            });
          },
        ),
      ) : ActiveListeningViewMode(id: _id,),
    );
  }

  _detailModeButton(){
    return FloatingActionButton(
      backgroundColor: MyBlue.picton,
      foregroundColor: Colors.white,
      child: (_editMode) ? Icon(Icons.remove_red_eye) : Icon(Icons.edit),
      onPressed:(){
        setState(() {
          _editMode = !_editMode;
        });
      });
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
            position: currentPage.toDouble(),
            decorator: DotsDecorator(activeColor: MyBlue.seagull),
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

