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


@UseMoor(tables: [Goals, SubTasks, Outputs], daos: [GoalDao, SubTaskDao, OutputDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase () : super(FlutterQueryExecutor.inDatabaseFolder(path: 'db.sqlite'));
  @override
  int get schemaVersion => 2;
  @override
  MigrationStrategy get migration => MigrationStrategy(
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
    onUpgrade: (Migrator m, int from, int to) async {
      if ( from == 1 ) {
        await m.deleteTable('goals');
        await m.deleteTable('subTasks');
        await m.deleteTable('outputs');
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

