import 'package:eit_app/screens/assessments/assessments_form.dart';
import 'package:eit_app/widgets/assessments/assessments_record_list.dart';
import 'package:eit_app/widgets/bottomnavbar.dart';
import 'package:eit_app/themes/apptheme.dart';
import 'package:eit_app/widgets/my_add_entry_button.dart';
import 'package:eit_app/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';

class AssessmentsList extends StatefulWidget {
  static const routeName = '/assessments_list';
  @override
  State<StatefulWidget> createState() {
    return _AssessmentsListState();
  }
}

class _AssessmentsListState extends State<AssessmentsList> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Builder(builder: (BuildContext context) {
        return Scaffold(
          resizeToAvoidBottomPadding: false,
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: MyAppBar(appBarBottom: Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: TabBar(
                labelColor: MyBlue.light,
                indicatorColor: MyBlue.light,
                unselectedLabelColor: Colors.grey,
                tabs: <Widget>[
                  Tab(text: "Mental Well Being",),
                  Tab(text: 'Emotional Intelligence',)
                ],
              ),
            ),),
          ),
          body: Padding(
            padding: EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
            child: CustomScrollView(
              slivers: <Widget>[
                SliverFillRemaining(
                  child: TabBarView(
                    children: <Widget>[
                      AssessmentRecordList(isMWB: true,),
                      AssessmentRecordList(isMWB: false,)
                    ],
                  ),
                )
              ],
            ),
          ),
          bottomNavigationBar: BottomNavBar(),
          floatingActionButton: AddEntryButton(onPressed: () {
            final _tabIndex = DefaultTabController.of(context).index;
            Navigator.pushNamed(context, TakeAssessment.routeName, arguments: ( _tabIndex == 0 ));
          },),
        );
      },),
    );
  }
}