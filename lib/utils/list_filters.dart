import 'package:eit_app/utils/const_list_and_enum.dart';
import 'package:eit_app/utils/project_db.dart';


bool isSameDate(DateTime date1, DateTime date2) => (date1.month == date2.month && date1.day == date2.day && date1.year == date2.year);
bool isSameMonth(DateTime date1, DateTime date2) => (date1.month == date2.month && date1.year == date2.year);
bool isSameWeek(DateTime date1, DateTime date2) {
  final DateTime _earlyDateStartWeek = DateTime(date1.year, date1.month, date1.day).subtract(Duration(days:date1.weekday ));
  final DateTime _lateDateStartWeek = DateTime(date2.year, date2.month, date2.day).subtract(Duration(days:date2.weekday ));
  return (_earlyDateStartWeek == _lateDateStartWeek);
}
String dateFilterToString(DateFilter filter){
  switch(filter) {
    case DateFilter.Today: {
      return "Today";
    }
    break;
    case DateFilter.Week: {
      return "This Week";
    }
    break;
    case DateFilter.Month: {
      return "This Month";
    }
    break;
    case DateFilter.All: { return "All Tasks"; }
    break;
    case DateFilter.Null: { return "Other Tasks"; }
    break;
    default: { return "All Tasks"; }
    break;
  }

}

// ___ Goal Filters ___ //
List<Goal> filterOnGoingGoals(List<Goal> goals, DateFilter filter) {
  switch(filter) {
    case DateFilter.Today: {
      return goals.where((goal) => goal.completed == false && goal.dueDate != null && isSameDate(DateTime.now(), goal.dueDate)).toList();
    }
    break;
    case DateFilter.Week: {
      return goals.where((goal) => goal.completed == false && goal.dueDate != null && isSameWeek(DateTime.now(), goal.dueDate)).toList();
    }
    break;
    case DateFilter.Month: {
      return goals.where((goal) => goal.completed == false && goal.dueDate != null && isSameMonth(DateTime.now(), goal.dueDate)).toList();
    }
    break;
    case DateFilter.All: { return goals.where((goal) => goal.completed == false ).toList(); }
    break;
    case DateFilter.Null: { return goals.where((goal) => goal.completed == false && goal.dueDate == null ).toList(); }
    break;
    default: { return goals; }
    break;
  }
}
List<Goal> filterCompletedGoals(List<Goal> goals, DateFilter filter) {
  switch(filter) {
    case DateFilter.Today: {
      return goals.where((goal) => goal.completed && goal.dueDate != null && isSameDate(DateTime.now(), goal.dueDate)).toList();
    }
    break;
    case DateFilter.Week: {
      return goals.where((goal) => goal.completed && goal.dueDate != null && isSameWeek(DateTime.now(), goal.dueDate)).toList();
    }
    break;
    case DateFilter.Month: {
      return goals.where((goal) => goal.completed && goal.dueDate != null && isSameMonth(DateTime.now(), goal.dueDate)).toList();
    }
    break;
    case DateFilter.All: { return goals.where((goal) => goal.completed == true ).toList(); }
    break;
    case DateFilter.Null: { return goals.where((goal) => goal.completed && goal.dueDate == null ).toList(); }
    break;
    default: { return goals; }
    break;
  }
}


// ___ Active Listening filters ___ //
List<Listen> filterListenRecords(List<Listen> list, DateFilter filter) {
  switch(filter) {
    case DateFilter.Today: {
      return list.where((list) => list.dateCreated != null && isSameDate(DateTime.now(), list.dateCreated)).toList();
    }
    break;
    case DateFilter.Week: {
      return list.where((list) => list.dateCreated != null && isSameWeek(DateTime.now(), list.dateCreated)).toList();
    }
    break;
    case DateFilter.Month: {
      return list.where((list) => list.dateCreated != null && isSameMonth(DateTime.now(), list.dateCreated)).toList();
    }
    break;
    default: { return list; }
    break;
  }
}

// ___ Active Listening filters ___ //
List<Journal> filterJournalRecords(List<Journal> list, DateFilter filter) {
  switch(filter) {
    case DateFilter.Today: {
      return list.where((list) => list.dateCreated != null && isSameDate(DateTime.now(), list.dateCreated)).toList();
    }
    break;
    case DateFilter.Week: {
      return list.where((list) => list.dateCreated != null && isSameWeek(DateTime.now(), list.dateCreated)).toList();
    }
    break;
    case DateFilter.Month: {
      return list.where((list) => list.dateCreated != null && isSameMonth(DateTime.now(), list.dateCreated)).toList();
    }
    break;
    default: { return list; }
    break;
  }
}