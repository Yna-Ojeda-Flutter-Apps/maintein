import 'package:maintein/screens/active_listening/active_new.dart';
import 'package:maintein/utils/const_list_and_enum.dart';
import 'package:maintein/widgets/active_listening/active_listening_record_list.dart';
import 'package:maintein/widgets/bottomnavbar.dart';
import 'package:maintein/widgets/my_add_entry_button.dart';
import 'package:maintein/widgets/my_app_bar.dart';
import 'package:maintein/widgets/praise_section.dart';
import 'package:maintein/widgets/prompt_generator.dart';
import 'package:maintein/themes/apptheme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class ActiveListenList extends StatefulWidget{
  static const routeName = '/listen_list';

  @override
  State<StatefulWidget> createState() {
    return _ActiveListenListState();
  }
}

class _ActiveListenListState extends State<ActiveListenList>{
  String _currentFilterString;
  DateFilter _currentFilter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: MyAppBar(
          flexibleSpaceChild: FlatButton(
            child: Text(_currentFilterString ?? "Today", style: Theme.of(context).textTheme.title.copyWith(color: MyBlue.light),),
            onPressed: () {
              _showFilterOptions(context);
            },
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPadding(padding: EdgeInsets.all(10), sliver: SliverList(delegate: SliverChildListDelegate([
              PromptGenerator(conversationPrompts, conversationPromptHeader),
              PraiseSection(isJournal: false,),
            ]),),),
            ActiveListeningRecordList(currentFilter: _currentFilter ?? DateFilter.Today,),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
      floatingActionButton: AddEntryButton(onPressed: () => Navigator.pushNamed(context, ActiveListenNewForm.routeName),),
    );
  }

  void _showFilterOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: Text("Show entries from:"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _createFilterOption("Today", DateFilter.Today),
              _createFilterOption("This Week", DateFilter.Week),
              _createFilterOption("This Month", DateFilter.Month),
              _createFilterOption("All Entries", DateFilter.All),
            ],
          ),
        );
      }
    );
  }
  RadioListTile _createFilterOption(String title, DateFilter option) {
    return RadioListTile<DateFilter>(
      title: Text(title),
      value: option,
      groupValue: _currentFilter ?? DateFilter.Today,
      onChanged: (DateFilter value) {
        setState(() {
          _currentFilter = value;
          if ( title == 'This Month' ){
            _currentFilterString = DateFormat('MMMM').format(DateTime.now());
          } else {
            _currentFilterString = title;
          }
          Navigator.of(context).pop();
        });
      },
    );
  }


}