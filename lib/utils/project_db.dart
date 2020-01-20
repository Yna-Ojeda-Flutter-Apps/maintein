import 'package:moor_flutter/moor_flutter.dart';
import 'package:rxdart/rxdart.dart';
part 'project_db.g.dart';


class Goals extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get urgency => integer()();
  TextColumn get task => text()();
  DateTimeColumn get dueDate => dateTime().nullable()();
  BoolColumn get completed => boolean().withDefault(Constant(false))();
}

class SubTasks extends Table {
  IntColumn get id => integer().customConstraint('REFERENCES goals(id) ON DELETE CASCADE')();
  TextColumn get task => text()();
  BoolColumn get completed => boolean().withDefault(Constant(false))();

  @override
  Set<Column> get primaryKey => {id, task};
}
class Outputs extends Table {
  IntColumn get id => integer().customConstraint('REFERENCES goals(id) ON DELETE CASCADE')();
  TextColumn get item => text()();
  BoolColumn get completed => boolean().withDefault(Constant(false))();

  @override
  Set<Column> get primaryKey => {id, item};
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
  TextColumn get feelings =>  text()();
  TextColumn get evaluation => text()();
  TextColumn get analysis => text()();
  TextColumn get conclusion => text()();
  TextColumn get actionPlan  => text()();
}

class Assessments extends Table {
  IntColumn get id => integer().autoIncrement()();
  BoolColumn get isMWB => boolean().withDefault(Constant(true))();
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
  TextColumn get actName => text().withLength(min:1)();
  TextColumn get insights => text().withLength(min:1)();
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
@UseMoor(tables: [Goals, SubTasks, Outputs, Journals, Assessments, Questions, Listens, Descs], daos: [GoalDao, SubTaskDao, OutputDao, JournalDao, AssessmentDao, ListenDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase () : super(FlutterQueryExecutor.inDatabaseFolder(path: 'db.sqlite'));
  @override
  int get schemaVersion => 6;
  @override
  MigrationStrategy get migration => MigrationStrategy(
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if ( from == 5 ) {
          await m.deleteTable('goals');
          await m.deleteTable('subTasks');
          await m.deleteTable('outputs');
          await m.deleteTable('journals');
          await m.deleteTable('assessments');
          await m.deleteTable('questions');
          await m.deleteTable('descs');
          await m.createAllTables();
        }
      }
  );
}

@UseDao(tables: [Goals, SubTasks, Outputs])
class GoalDao extends DatabaseAccessor<AppDatabase> with _$GoalDaoMixin {
  final AppDatabase db;

  GoalDao(this.db) : super(db);

  Stream<List<SmartGoal>> watchAllGoals() {
    final goalStream = Observable(
        (select(goals)
          ..orderBy(
            ([
                  (t) =>
                  OrderingTerm(expression: t.dueDate, mode: OrderingMode.desc),
                  (t) =>
                  OrderingTerm(expression: t.urgency, mode: OrderingMode.desc),
                  (t) => OrderingTerm(expression: t.task),
            ]),
          )).watch());
    return goalStream.switchMap((entries) {
      final idToEntry = { for (var entry in entries) entry.id: entry};
      final ids = idToEntry.keys;

      final entryQuery = select(goals).join([
        leftOuterJoin(subTasks, subTasks.id.equalsExp(goals.id)),
        leftOuterJoin(outputs, outputs.id.equalsExp(goals.id)),
      ]);
      return entryQuery.watch().map((rows) {
        final idToSubTasks = <int, List<SubTask>>{};
        final idToOutputs = <int, List<Output>>{};
        for (var row in rows) {
          final subTask = row.readTable(subTasks);
          final output = row.readTable(outputs);
          final id = row
              .readTable(goals)
              .id;
          idToSubTasks.putIfAbsent(id, () => []).add(subTask);
          idToOutputs.putIfAbsent(id, () => []).add(output);
        }
        return [
          for (var id in ids )
            SmartGoal(goal: idToEntry[id],
                subTask: idToSubTasks[id] ?? [],
                output: idToOutputs[id] ?? []),
        ];
      });
    });
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

  Stream<List<Journal>> watchJournalEntries() => select(journals).watch();
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

  Stream<List<AssessmentRecord>> watchAllMWB() {
    final recordStream = Observable(
        (
            select(assessments)
              ..orderBy([
                    (t) =>
                    OrderingTerm(expression: t.dateCreated, mode: OrderingMode.desc),
              ])
              ..where((assessment) => assessment.isMWB)
        ).watch()
    );
    return recordStream.switchMap((records) {
      final idToRecord = { for ( var record in records ) record.id: record };
      final ids = idToRecord.keys;
      final recordQuery = select(assessments).join([
        leftOuterJoin(questions, questions.id.equalsExp(assessments.id)),
      ]);
      return recordQuery.watch().map((rows) {
        final idToQuestions = <int, List<Question>>{};
        for ( var row in rows ) {
          final question = row.readTable(questions);
          final id = row
              .readTable(assessments)
              .id;
          idToQuestions.putIfAbsent(id, () => []).add(question);
        }
        return [
          for ( var id in ids )
            AssessmentRecord(
                info: idToRecord[id],
                question: idToQuestions[id] ?? []
            )
        ];
      });
    });
  }
  Stream<List<AssessmentRecord>> watchAllEIS() {
    final recordStream = Observable(
        (
            select(assessments)
              ..orderBy([
                    (t) =>
                    OrderingTerm(expression: t.dateCreated, mode: OrderingMode.desc),
              ])
              ..where((assessment) => assessment.isMWB.equals(false))
        ).watch()
    );
    return recordStream.switchMap((records) {
      final idToRecord = { for ( var record in records ) record.id: record };
      final ids = idToRecord.keys;
      final recordQuery = select(assessments).join([
        leftOuterJoin(questions, questions.id.equalsExp(assessments.id)),
      ]);
      return recordQuery.watch().map((rows) {
        final idToQuestions = <int, List<Question>>{};
        for ( var row in rows ) {
          final question = row.readTable(questions);
          final id = row
              .readTable(assessments)
              .id;
          idToQuestions.putIfAbsent(id, () => []).add(question);
        }
        return [
          for ( var id in ids )
            AssessmentRecord(
                info: idToRecord[id],
                question: idToQuestions[id] ?? []
            )
        ];
      });
    });
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

@UseDao(tables: [Listens, Descs])
class ListenDao extends DatabaseAccessor<AppDatabase> with _$ListenDaoMixin {
  final AppDatabase db;
  ListenDao(this.db) : super(db);

  Stream<List<ListenRecord>> watchActiveListenEntries(){
      final entryStream = Observable(
          (
            select(listens)
              ..orderBy([
                (t) => OrderingTerm(expression: t.dateCreated, mode: OrderingMode.desc),
              ])
          ).watch()
      );

      return entryStream.switchMap((entries){
        final idToEntry = { for (var entry in entries) entry.id : entry};
        final ids = idToEntry.keys;
        final entryQuery = select(listens).join([
          leftOuterJoin(descs, descs.id.equalsExp(listens.id)),
        ]);
        return entryQuery.watch().map((rows){
          final idToDescs = <int, List<Desc>>{};
          for (var row in rows){
            final desc = row.readTable(descs);
            final id = row.readTable(listens).id;
            idToDescs.putIfAbsent(id, ()=> []).add(desc);
          }
          return [
            for (var id in ids)
              ListenRecord(
                detail: idToEntry[id],
                desc: idToDescs[id] ?? []
              )
          ];
        });

      });
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
        (Listen listen, List<Desc> descs){
          return ListenRecord(
            detail: listen,
            desc: descs,
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


