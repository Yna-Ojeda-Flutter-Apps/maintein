import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info/device_info.dart';
import 'package:maintein/screens/active_listening/active_detail.dart';
import 'package:maintein/screens/breathing/breathing_exercise.dart';
import 'package:maintein/screens/goaltracker/goal_detail.dart';
import 'package:maintein/screens/journal/journal_detail.dart';
import 'package:maintein/utils/const_list_and_enum.dart';
import 'package:intl/intl.dart';
import 'package:maintein/utils/list_filters.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:rxdart/rxdart.dart';
import 'package:moor/moor.dart' as moorPackage;
import 'package:shared_preferences/shared_preferences.dart';
part 'project_db.g.dart';

class Goals extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get dateCreated => dateTime()();
  IntColumn get urgency => integer()();
  TextColumn get task => text().nullable()();
  BoolColumn get completed => boolean().withDefault(Constant(false))();
  DateTimeColumn get dueDate => dateTime().nullable()();
  DateTimeColumn get dateCompleted => dateTime().nullable()();
}
class SubTasks extends Table {
  IntColumn get sId => integer().autoIncrement()();
  DateTimeColumn get dateCreated => dateTime()();
  IntColumn get id => integer().customConstraint('REFERENCES goals(id) ON DELETE CASCADE')();
  TextColumn get task => text().nullable()();
  BoolColumn get completed => boolean().withDefault(Constant(false))();
}
class Outputs extends Table {
  IntColumn get oId => integer().autoIncrement()();
  DateTimeColumn get dateCreated => dateTime()();
  IntColumn get id => integer().customConstraint('REFERENCES goals(id) ON DELETE CASCADE')();
  TextColumn get item => text().nullable()();
  BoolColumn get completed => boolean().withDefault(Constant(false))();
}
class SmartGoal {
  final Goal goal;
  final List<SubTask> subTask;
  final List<Output> output;
  SmartGoal({this.goal, this.subTask, this.output});
}

class Journals extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get dateCreated => dateTime()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  TextColumn get feelings =>  text().nullable()();
  TextColumn get evaluation => text().nullable()();
  TextColumn get analysis => text().nullable()();
  TextColumn get conclusion => text().nullable()();
  TextColumn get actionPlan  => text().nullable()();
}

class Assessments extends Table {
  IntColumn get id => integer().autoIncrement()();
  BoolColumn get isMWB => boolean().withDefault(Constant(true))();
  IntColumn get score => integer().withDefault(Constant(1))();
  DateTimeColumn get dateCreated => dateTime().withDefault(Constant(DateTime.now()))();
}
class Questions extends Table {
  IntColumn get id => integer().customConstraint('REFERENCES assessments(id) ON DELETE CASCADE')();
  IntColumn get qId => integer()();
  IntColumn get score => integer().withDefault(Constant(0))();

  @override
  Set<Column> get primaryKey => {id, qId};
}
class AssessmentRecord {
  final Assessment info;
  final List<Question> question;
  AssessmentRecord({this.info, this.question});
}

class Listens extends Table{
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get dateCreated => dateTime().withDefault(Constant(DateTime.now()))();
  TextColumn get actName => text()();
  TextColumn get insights => text()();
  IntColumn get descriptionCount => integer().nullable()();
}
class Descs extends Table{
  IntColumn get id => integer().customConstraint('REFERENCES listens(id) ON DELETE CASCADE')();
  IntColumn get cId => integer()();
  BoolColumn get charVal => boolean().withDefault(Constant(false))();

  @override
  Set<Column> get primaryKey => {id, cId};
}
class ListenRecord{
  final Listen detail;
  final List<Desc> desc;
  ListenRecord({this.detail,this.desc});
}

class Reminders extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get type => text()();
  DateTimeColumn get time => dateTime().withDefault(Constant(DateTime(1,1,1,8)))();
  BoolColumn get isDaily => boolean().withDefault(Constant(true))();
}



@UseMoor(tables: [Goals, SubTasks, Outputs, Journals, Assessments, Questions, Listens, Descs, Reminders], daos: [GoalDao, SubTaskDao, OutputDao, JournalDao, AssessmentDao, ListenDao, ReminderDao, CollectorDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase () : super(FlutterQueryExecutor.inDatabaseFolder(path: 'db.sqlite'));
  @override
  int get schemaVersion => 1;
  @override
  MigrationStrategy get migration => MigrationStrategy(
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
      },
  );
}

@UseDao(tables: [Goals, SubTasks, Outputs])
class GoalDao extends DatabaseAccessor<AppDatabase> with _$GoalDaoMixin {
  final AppDatabase db;

  GoalDao(this.db) : super(db);

  Stream<List<Goal>> watchAllEntries() {
    return (select(goals)
      ..orderBy(
        ([
              (t) =>
              OrderingTerm(expression: t.dueDate, mode: OrderingMode.desc),
              (t) =>
              OrderingTerm(expression: t.urgency, mode: OrderingMode.desc),
              (t) => OrderingTerm(expression: t.task),
        ]),
      )).watch();
  }
  Stream<SmartGoal> watchGoal(int id) {
    final goalQuery = select(goals)..where((goal) => goal.id.equals(id));
    final subTaskQuery = select(goals).join(
      [
        leftOuterJoin(subTasks, subTasks.id.equalsExp(goals.id)),
      ],
    )..where(goals.id.equals(id));
    final outputQuery = select(goals).join(
      [
        leftOuterJoin(outputs, outputs.id.equalsExp(goals.id)),
      ],
    )..where(goals.id.equals(id));
    final goalStream = goalQuery.watchSingle();
    final subTaskStream = subTaskQuery.watch().map(
            (rows) {
          return rows.map((row) => row.readTable(subTasks)).toList();
        }
    );
    final outputStream = outputQuery.watch().map(
            (rows) {
          return rows.map((row) => row.readTable(outputs)).toList();
        }
    );
    return Observable.combineLatest3(
        goalStream,
        subTaskStream,
        outputStream,
            (Goal goal, List<SubTask> tasks, List<Output> output) {
          return SmartGoal(goal: goal, subTask: tasks, output: output);
        }
    );
  }

  Future<List<SmartGoal>> getAllEntries() async {
    List<SmartGoal> list = [];
    List<Goal> goalQuery = await (select(goals)).get();
    goalQuery.forEach((item) async {
      List<SubTask> subTaskQuery = await (select(subTasks)..where((task) => task.id.equals(item.id))).get();
      List<Output> outputQuery = await (select(outputs)..where((o) => o.id.equals(item.id))).get();
      list.add(
        SmartGoal(
          goal: item,
          subTask: subTaskQuery,
          output: outputQuery,
        )
      );
    });
    return list;
  }

  Future insertGoal(Insertable<Goal> goal) => into(goals).insert(goal);
  Future updateGoal(Insertable<Goal> goal) => update(goals).replace(goal);
  Future deleteGoal(Insertable<Goal> goal) => delete(goals).delete(goal);
}
@UseDao(tables: [SubTasks])
class SubTaskDao extends DatabaseAccessor<AppDatabase> with _$SubTaskDaoMixin {
  final AppDatabase db;
  SubTaskDao(this.db) : super(db);

  Stream<List<SubTask>> watchSubTasks() => select(subTasks).watch();

  Future insertSubTask(Insertable<SubTask> task) => into(subTasks).insert(task);
  Future updateSubTask(Insertable<SubTask> task) => update(subTasks).replace(task);
  Future deleteSubTask(Insertable<SubTask> task) => delete(subTasks).delete(task);
}
@UseDao(tables: [Outputs])
class OutputDao extends DatabaseAccessor<AppDatabase> with _$OutputDaoMixin {
  final AppDatabase db;
  OutputDao(this.db) : super(db);

  Stream<List<Output>> watchSubTasks() => select(outputs).watch();

  Future insertOutput(Insertable<Output> output) => into(outputs).insert(output);
  Future updateOutput(Insertable<Output> output) => update(outputs).replace(output);
  Future deleteOutput(Insertable<Output> output) => delete(outputs).delete(output);
}

@UseDao(tables: [Journals])
class JournalDao extends DatabaseAccessor<AppDatabase> with _$JournalDaoMixin {
  final AppDatabase db;
  JournalDao(this.db) : super(db);

  Stream<List<Journal>> watchAllEntries() {
    return (
        select(journals)
          ..orderBy([
                (t) => OrderingTerm(expression: t.dateCreated, mode: OrderingMode.desc),
          ])
    ).watch();
  }

  Stream<Journal> watchJournalEntry(int id) {
    final entryQuery =  select(journals)..where((entry) => entry.id.equals(id));
    return entryQuery.watchSingle();
  }

  Future<List<Journal>> getAllEntries() => select(journals).get();
  Future insertJournalEntry(Insertable<Journal> entry) => into(journals).insert(entry);
  Future updateJournalEntry(Insertable<Journal> entry) => update(journals).replace(entry);
  Future deleteJournalEntry(Insertable<Journal> entry) => delete(journals).delete(entry);
}

@UseDao (tables: [Assessments, Questions])
class AssessmentDao extends DatabaseAccessor<AppDatabase> with _$AssessmentDaoMixin {
  final AppDatabase db;

  AssessmentDao(this.db) : super(db);

  Stream<List<Assessment>> watchAllMWB() {
    return (
        select(assessments)
          ..orderBy([
                (t) => OrderingTerm(expression: t.dateCreated, mode: OrderingMode.desc),
          ])
        ..where((t) => t.isMWB.equals(true))
    ).watch();
  }
  Stream<List<Assessment>> watchAllEIS() {
    return (
        select(assessments)
          ..orderBy([
                (t) => OrderingTerm(expression: t.dateCreated, mode: OrderingMode.desc),
          ])
          ..where((t) => t.isMWB.equals(false))
    ).watch();
  }
  Stream<AssessmentRecord> watchAssessment(int id) {
    final assessmentQuery = select(assessments)..where((record) => record.id.equals(id));
    final questionQuery = select(assessments).join([
      leftOuterJoin(questions, questions.id.equalsExp(assessments.id)),
    ],)..where(assessments.id.equals(id));
    final assessmentStream = assessmentQuery.watchSingle();
    final questionStream = questionQuery.watch().map(
            (rows) {
          return rows.map((row) => row.readTable(questions)).toList();
        }
    );
    return Observable.combineLatest2(
        assessmentStream,
        questionStream,
            (Assessment assessment, List<Question> questions) {
          return AssessmentRecord(
              info: assessment,
              question: questions
          );
        }
    );
  }

  Future<List<Assessment>> getAllAssessments() => select(assessments).get();
  Future insertAssessment(Insertable<Assessment> info) => into(assessments).insert(info);
  Future insertQuestion(Insertable<Question> question) => into(questions).insert(question);
  Future updateAssessment(Insertable<Assessment> info) => update(assessments).replace(info);
  Future deleteAssessment(Insertable<Assessment> info) => delete(assessments).delete(info);
}

@UseDao(tables: [Listens, Descs],)
class ListenDao extends DatabaseAccessor<AppDatabase> with _$ListenDaoMixin {
  final AppDatabase db;
  ListenDao(this.db) : super(db);


  Stream<List<Listen>> watchAll() {
    return (
        select(listens)
          ..orderBy([
                (t) => OrderingTerm(expression: t.dateCreated, mode: OrderingMode.desc),
          ])
    ).watch();
  }

  Stream<ListenRecord> watchListenEntry(int id) {
    final listenQuery = select(listens)..where((entry) => entry.id.equals(id));
    final descQuery = select(listens).join([leftOuterJoin(descs,descs.id.equalsExp(listens.id))],)
      ..where(listens.id.equals(id));
    final entryStream = listenQuery.watchSingle();
    final descStream = descQuery.watch().map(
        (rows){
          return rows.map((row) => row.readTable(descs)).toList();
        }
    );

    return Observable.combineLatest2(
      entryStream,
      descStream,
        (Listen listen, List<Desc> description){
          return ListenRecord(
            detail: listen,
            desc: description,
          );
        }
    );
  }

  Future<List<Listen>> getAllEntries() => select(listens).get();
  Future insertListenActivity(Insertable<Listen> activity) => into(listens).insert(activity);
  Future updateListenActivity(Insertable<Listen> activity) => update(listens).replace(activity);
  Future deleteListenActivity(Insertable<Listen> activity) => delete(listens).delete(activity);

  Future insertDesc(Insertable<Desc> desc) => into(descs).insert(desc);
  Future updateDesc(Insertable<Desc> desc) => update(descs).replace(desc);
}


@UseDao(tables: [Reminders],)
class ReminderDao extends DatabaseAccessor<AppDatabase> with _$ReminderDaoMixin {
  final AppDatabase db;
  ReminderDao(this.db) : super(db);

  Stream<List<Reminder>> watchAllEntries() => select(reminders).watch();
  Future<List<Reminder>> getAllEntries() => select(reminders).get();

  Future setInitialReminders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if ( prefs.getBool("toInitializeReminders") ?? true ) {
      await prefs.setBool("toInitializeReminders", false);
      return transaction(() async {
        final assessmentReminder = RemindersCompanion(
          type: moorPackage.Value(reminderTypes[0]),
          isDaily: moorPackage.Value(false),
        );
        await into(reminders).insert(assessmentReminder);
        for (int i = 1; i < reminderTypes.length; i++) {
          final record = RemindersCompanion(
            type: moorPackage.Value(reminderTypes[i]),
          );
          await into(reminders).insert(record);
        }
      });
    }
  }


  Future insertReminder(Insertable<Reminder> entry) => into(reminders).insert(entry);
  Future updateReminder(Insertable<Reminder> entry) => update(reminders).replace(entry);
  Future deleteReminder(Insertable<Reminder> entry) => delete(reminders).delete(entry);
}

@UseDao(tables: [Goals, SubTasks, Outputs, Journals, Assessments, Questions, Listens, Descs],)
class CollectorDao extends DatabaseAccessor<AppDatabase> with _$CollectorDaoMixin {
  final AppDatabase db;
  CollectorDao(this.db) : super(db);

  Future collectData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String lastCollectedString = prefs.getString("last collected") ?? "19990122";
    DateTime lastCollectedDate = DateTime.parse(lastCollectedString);
    bool toCollect = !isSameDate(lastCollectedDate, DateTime.now());
    
    if ( toCollect ) {
      await prefs.setString("last collected", DateFormat("yyyyMMdd").format(DateTime.now()));
      return transaction(() async {
        DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
        String identifier;
        if ( Platform.isAndroid ) {
          AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
          identifier = androidInfo.androidId;
        } else if ( Platform.isIOS ) {
          IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
          identifier = iosDeviceInfo.identifierForVendor;
        } else {
          identifier = "Could not identify";
        }
        List<Journal> journalEntries = await (select(journals)..where((entry) => entry.dateCreated.isBetweenValues(lastCollectedDate, DateTime.now()))).get();
        List<Goal> goalEntries = await (select(goals)..where((entry) => entry.dateCreated.isBetweenValues(lastCollectedDate, DateTime.now()))).get();
        List<SubTask> subTaskEntries = await (select(subTasks)..where((entry) => entry.dateCreated.isBetweenValues(lastCollectedDate, DateTime.now()))).get();
        List<Output> outputEntries = await (select(outputs)..where((entry) => entry.dateCreated.isBetweenValues(lastCollectedDate, DateTime.now()))).get();
        List<Listen> listenEntries = await (select(listens)..where((entry) => entry.dateCreated.isBetweenValues(lastCollectedDate, DateTime.now()))).get();
        List<Assessment> assessmentEntries = await (select(assessments)..where((entry) => entry.dateCreated.isBetweenValues(lastCollectedDate, DateTime.now()))).get();
        var averageEntryLength = 0;
        (journalEntries ?? []).forEach((entry) {
          averageEntryLength = averageEntryLength + (entry.description ?? "").length +
            (entry.feelings ?? "").length +
            (entry.evaluation ?? "").length +
            (entry.analysis ?? "").length +
            (entry.conclusion ?? "").length +
            (entry.actionPlan ?? "").length;
        });
        await Firestore.instance.collection('journal').document("["+DateFormat("yyyyMMdd").format(DateTime.now())+"]"+identifier).setData({
          "userId": identifier,
          "date": DateTime.now(),
          "promptAccess": prefs.getInt("Journal Prompt Access") ?? 0,
          "entryCount": (journalEntries ?? []).length,
          "detailAccess": prefs.getInt(JournalDetail.routeName + ' screen') ?? 0,
          "aveLength": averageEntryLength
        });

        averageEntryLength = 0;
        (listenEntries ?? []).forEach((entry) {
          averageEntryLength = averageEntryLength + entry.descriptionCount;
        });
        await Firestore.instance.collection('activeListening').document("["+DateFormat("yyyyMMdd").format(DateTime.now())+"]"+identifier).setData({
          "userId": identifier,
          "date": DateTime.now(),
          "promptAccess": prefs.getInt("Listening Prompt Access") ?? 0,
          "entryCount": (listenEntries ?? []).length,
          "detailAccess": prefs.getInt(ActiveListenDetail.routeName + ' screen') ?? 0,
          "aveLength": averageEntryLength
        });
        await Firestore.instance.collection('goal').document("["+DateFormat("yyyyMMdd").format(DateTime.now())+"]"+identifier).setData({
          "userId": identifier,
          "date": DateTime.now(),
          "detailAccess": prefs.getInt(GoalDetail.routeName + ' screen') ?? 0,
          "goalCount": (goalEntries ?? []).length,
          "outputCount": (outputEntries ?? []).length,
          "subtaskCount": (subTaskEntries ?? []).length,
          "completedGoalCount": (goalEntries ?? []).where((entry) => entry.completed).length,
          "completedSubTaskCount": (outputEntries ?? []).where((entry) => entry.completed).length,
          "completedOutputCount": (subTaskEntries ?? []).where((entry) => entry.completed).length,
        });

        List<Map<String, dynamic>> assessmentsEntryList = [];
        (assessmentEntries ?? []).forEach((entry) => assessmentsEntryList.add({'identifier': identifier, 'date': entry.dateCreated, 'isMWB': entry.isMWB, 'score': entry.score}));

        await Firestore.instance.collection('others').document("["+DateFormat("yyyyMMdd").format(DateTime.now())+"]"+identifier).setData({
          "userId": identifier,
          "date": DateTime.now(),
          "breatheAccess": prefs.getInt(BreathingExercise.routeName + ' screen') ?? 0,
          "assessments": assessmentsEntryList,
        });
      });
    } else {
      return Future.value(-1);
    }
  }


}



