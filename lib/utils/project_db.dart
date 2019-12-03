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

class Listens extends Table{
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get dateCreated => dateTime()();
  TextColumn get actName => text()();
  TextColumn get insights => text()();
  BoolColumn get iHad1 => boolean().withDefault(Constant(false))();
  BoolColumn get iHad2 => boolean().withDefault(Constant(false))();
  BoolColumn get iHad3 => boolean().withDefault(Constant(false))();
  BoolColumn get iHad4 => boolean().withDefault(Constant(false))();
  BoolColumn get iGave1 => boolean().withDefault(Constant(false))();
  BoolColumn get iGave2 => boolean().withDefault(Constant(false))();
  BoolColumn get iGave3 => boolean().withDefault(Constant(false))();
  BoolColumn get iCan1 => boolean().withDefault(Constant(false))();
  BoolColumn get iCan2 => boolean().withDefault(Constant(false))();
  BoolColumn get ididNot1 => boolean().withDefault(Constant(false))();
  BoolColumn get ididNot2 => boolean().withDefault(Constant(false))();
  BoolColumn get ididNot3 => boolean().withDefault(Constant(false))();
}



@UseMoor(tables: [Goals, SubTasks, Outputs, Journals, Listens], daos: [GoalDao, SubTaskDao, OutputDao, JournalDao, ListenDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase () : super(FlutterQueryExecutor.inDatabaseFolder(path: 'db.sqlite'));
  @override
  int get schemaVersion => 4;
  @override
  MigrationStrategy get migration => MigrationStrategy(
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
    onUpgrade: (Migrator m, int from, int to) async {
      if ( from == 3 ) {
        await m.deleteTable('goals');
        await m.deleteTable('subTasks');
        await m.deleteTable('outputs');
        await m.deleteTable('journals');
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

@UseDao(tables: [Listens])
class ListenDao extends DatabaseAccessor<AppDatabase> with _$ListenDaoMixin {
  final AppDatabase db;
  ListenDao(this.db) : super(db);

  Stream<List<Listen>> watchActiveListenEntries() => select(listens).watch();
  Stream<Listen> watchListenEntry(int id) {
    final activityEntry = select(listens)..where((activity) => activity.id.equals(id));
    return activityEntry.watchSingle();
  }

  Future insertListenActivity(Insertable<Listen> activity) => into(listens).insert(activity);
  Future updateListenActivity(Insertable<Listen> activity) => update(listens).replace(activity);
  Future deleteListenActivity(Insertable<Listen> activity) => delete(listens).delete(activity);

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


