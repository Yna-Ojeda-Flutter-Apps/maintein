import 'package:eit_app/utils/const_list_and_enum.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:rxdart/rxdart.dart';
import 'package:moor/moor.dart' as moorPackage;
part 'project_db.g.dart';

class Goals extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get urgency => integer()();
  TextColumn get task => text().nullable()();
  BoolColumn get completed => boolean().withDefault(Constant(false))();
  DateTimeColumn get dueDate => dateTime().nullable()();
  DateTimeColumn get dateCompleted => dateTime().nullable()();
}
class SubTasks extends Table {
  IntColumn get sId => integer().autoIncrement()();
  IntColumn get id => integer().customConstraint('REFERENCES goals(id) ON DELETE CASCADE')();
  TextColumn get task => text().nullable()();
  BoolColumn get completed => boolean().withDefault(Constant(false))();
}
class Outputs extends Table {
  IntColumn get oId => integer().autoIncrement()();
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



@UseMoor(tables: [Goals, SubTasks, Outputs, Journals, Assessments, Questions, Listens, Descs, Reminders], daos: [GoalDao, SubTaskDao, OutputDao, JournalDao, AssessmentDao, ListenDao, ReminderDao])
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

  void initializeReminders() async {
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
  }

  Future insertReminder(Insertable<Reminder> entry) => into(reminders).insert(entry);
  Future updateReminder(Insertable<Reminder> entry) => update(reminders).replace(entry);
  Future deleteReminder(Insertable<Reminder> entry) => delete(reminders).delete(entry);
}

