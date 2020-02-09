import 'package:eit_app/screens/journal/journal_new.dart';
import 'package:eit_app/utils/const_list_and_enum.dart';
import 'package:eit_app/widgets/bottomnavbar.dart';
import 'package:eit_app/widgets/journal/journal_record_list.dart';
import 'package:eit_app/widgets/my_add_entry_button.dart';
import 'package:eit_app/widgets/my_app_bar.dart';
import 'package:eit_app/widgets/praise_section.dart';
import 'package:eit_app/widgets/prompt_generator.dart';
import 'package:eit_app/themes/apptheme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';



class JournalList extends StatefulWidget {
  static const routeName = '/journal_list';

  @override
  State<StatefulWidget> createState() {
    return _JournalListState();
  }
}

class _JournalListState extends State<JournalList> {
  String _currentFilterString;
  DateFilter _currentFilter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      resizeToAvoidBottomPadding: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: MyAppBar(
          flexibleSpaceChild: FlatButton(
            child: Text(_currentFilterString ?? "Today", style: Theme.of(context).textTheme.title.copyWith(color: MyBlue.light),),
            onPressed: () => _showFilterOptions(context),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPadding(padding: EdgeInsets.all(10), sliver: SliverList(delegate: SliverChildListDelegate([
              PromptGenerator(reflectionPrompts, journalPromptHeader),
              PraiseSection(isJournal: true,),
            ]),),),
            JournalRecordList(currentFilter: _currentFilter ?? DateFilter.Today,),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
      floatingActionButton: AddEntryButton(onPressed: () => Navigator.pushNamed(context, JournalNewForm.routeName),),
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