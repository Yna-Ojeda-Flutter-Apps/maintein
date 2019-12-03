// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Goal extends DataClass implements Insertable<Goal> {
  final int id;
  final int urgency;
  final String task;
  final DateTime dueDate;
  final bool completed;
  Goal(
      {@required this.id,
      @required this.urgency,
      @required this.task,
      this.dueDate,
      @required this.completed});
  factory Goal.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final boolType = db.typeSystem.forDartType<bool>();
    return Goal(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      urgency:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}urgency']),
      task: stringType.mapFromDatabaseResponse(data['${effectivePrefix}task']),
      dueDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}due_date']),
      completed:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}completed']),
    );
  }
  factory Goal.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Goal(
      id: serializer.fromJson<int>(json['id']),
      urgency: serializer.fromJson<int>(json['urgency']),
      task: serializer.fromJson<String>(json['task']),
      dueDate: serializer.fromJson<DateTime>(json['dueDate']),
      completed: serializer.fromJson<bool>(json['completed']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<int>(id),
      'urgency': serializer.toJson<int>(urgency),
      'task': serializer.toJson<String>(task),
      'dueDate': serializer.toJson<DateTime>(dueDate),
      'completed': serializer.toJson<bool>(completed),
    };
  }

  @override
  GoalsCompanion createCompanion(bool nullToAbsent) {
    return GoalsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      urgency: urgency == null && nullToAbsent
          ? const Value.absent()
          : Value(urgency),
      task: task == null && nullToAbsent ? const Value.absent() : Value(task),
      dueDate: dueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(dueDate),
      completed: completed == null && nullToAbsent
          ? const Value.absent()
          : Value(completed),
    );
  }

  Goal copyWith(
          {int id,
          int urgency,
          String task,
          DateTime dueDate,
          bool completed}) =>
      Goal(
        id: id ?? this.id,
        urgency: urgency ?? this.urgency,
        task: task ?? this.task,
        dueDate: dueDate ?? this.dueDate,
        completed: completed ?? this.completed,
      );
  @override
  String toString() {
    return (StringBuffer('Goal(')
          ..write('id: $id, ')
          ..write('urgency: $urgency, ')
          ..write('task: $task, ')
          ..write('dueDate: $dueDate, ')
          ..write('completed: $completed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(urgency.hashCode,
          $mrjc(task.hashCode, $mrjc(dueDate.hashCode, completed.hashCode)))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Goal &&
          other.id == this.id &&
          other.urgency == this.urgency &&
          other.task == this.task &&
          other.dueDate == this.dueDate &&
          other.completed == this.completed);
}

class GoalsCompanion extends UpdateCompanion<Goal> {
  final Value<int> id;
  final Value<int> urgency;
  final Value<String> task;
  final Value<DateTime> dueDate;
  final Value<bool> completed;
  const GoalsCompanion({
    this.id = const Value.absent(),
    this.urgency = const Value.absent(),
    this.task = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.completed = const Value.absent(),
  });
  GoalsCompanion.insert({
    this.id = const Value.absent(),
    @required int urgency,
    @required String task,
    this.dueDate = const Value.absent(),
    this.completed = const Value.absent(),
  })  : urgency = Value(urgency),
        task = Value(task);
  GoalsCompanion copyWith(
      {Value<int> id,
      Value<int> urgency,
      Value<String> task,
      Value<DateTime> dueDate,
      Value<bool> completed}) {
    return GoalsCompanion(
      id: id ?? this.id,
      urgency: urgency ?? this.urgency,
      task: task ?? this.task,
      dueDate: dueDate ?? this.dueDate,
      completed: completed ?? this.completed,
    );
  }
}

class $GoalsTable extends Goals with TableInfo<$GoalsTable, Goal> {
  final GeneratedDatabase _db;
  final String _alias;
  $GoalsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _urgencyMeta = const VerificationMeta('urgency');
  GeneratedIntColumn _urgency;
  @override
  GeneratedIntColumn get urgency => _urgency ??= _constructUrgency();
  GeneratedIntColumn _constructUrgency() {
    return GeneratedIntColumn(
      'urgency',
      $tableName,
      false,
    );
  }

  final VerificationMeta _taskMeta = const VerificationMeta('task');
  GeneratedTextColumn _task;
  @override
  GeneratedTextColumn get task => _task ??= _constructTask();
  GeneratedTextColumn _constructTask() {
    return GeneratedTextColumn(
      'task',
      $tableName,
      false,
    );
  }

  final VerificationMeta _dueDateMeta = const VerificationMeta('dueDate');
  GeneratedDateTimeColumn _dueDate;
  @override
  GeneratedDateTimeColumn get dueDate => _dueDate ??= _constructDueDate();
  GeneratedDateTimeColumn _constructDueDate() {
    return GeneratedDateTimeColumn(
      'due_date',
      $tableName,
      true,
    );
  }

  final VerificationMeta _completedMeta = const VerificationMeta('completed');
  GeneratedBoolColumn _completed;
  @override
  GeneratedBoolColumn get completed => _completed ??= _constructCompleted();
  GeneratedBoolColumn _constructCompleted() {
    return GeneratedBoolColumn('completed', $tableName, false,
        defaultValue: Constant(false));
  }

  @override
  List<GeneratedColumn> get $columns => [id, urgency, task, dueDate, completed];
  @override
  $GoalsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'goals';
  @override
  final String actualTableName = 'goals';
  @override
  VerificationContext validateIntegrity(GoalsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.urgency.present) {
      context.handle(_urgencyMeta,
          urgency.isAcceptableValue(d.urgency.value, _urgencyMeta));
    } else if (urgency.isRequired && isInserting) {
      context.missing(_urgencyMeta);
    }
    if (d.task.present) {
      context.handle(
          _taskMeta, task.isAcceptableValue(d.task.value, _taskMeta));
    } else if (task.isRequired && isInserting) {
      context.missing(_taskMeta);
    }
    if (d.dueDate.present) {
      context.handle(_dueDateMeta,
          dueDate.isAcceptableValue(d.dueDate.value, _dueDateMeta));
    } else if (dueDate.isRequired && isInserting) {
      context.missing(_dueDateMeta);
    }
    if (d.completed.present) {
      context.handle(_completedMeta,
          completed.isAcceptableValue(d.completed.value, _completedMeta));
    } else if (completed.isRequired && isInserting) {
      context.missing(_completedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Goal map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Goal.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(GoalsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.urgency.present) {
      map['urgency'] = Variable<int, IntType>(d.urgency.value);
    }
    if (d.task.present) {
      map['task'] = Variable<String, StringType>(d.task.value);
    }
    if (d.dueDate.present) {
      map['due_date'] = Variable<DateTime, DateTimeType>(d.dueDate.value);
    }
    if (d.completed.present) {
      map['completed'] = Variable<bool, BoolType>(d.completed.value);
    }
    return map;
  }

  @override
  $GoalsTable createAlias(String alias) {
    return $GoalsTable(_db, alias);
  }
}

class SubTask extends DataClass implements Insertable<SubTask> {
  final int id;
  final String task;
  final bool completed;
  SubTask({@required this.id, @required this.task, @required this.completed});
  factory SubTask.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    return SubTask(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      task: stringType.mapFromDatabaseResponse(data['${effectivePrefix}task']),
      completed:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}completed']),
    );
  }
  factory SubTask.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return SubTask(
      id: serializer.fromJson<int>(json['id']),
      task: serializer.fromJson<String>(json['task']),
      completed: serializer.fromJson<bool>(json['completed']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<int>(id),
      'task': serializer.toJson<String>(task),
      'completed': serializer.toJson<bool>(completed),
    };
  }

  @override
  SubTasksCompanion createCompanion(bool nullToAbsent) {
    return SubTasksCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      task: task == null && nullToAbsent ? const Value.absent() : Value(task),
      completed: completed == null && nullToAbsent
          ? const Value.absent()
          : Value(completed),
    );
  }

  SubTask copyWith({int id, String task, bool completed}) => SubTask(
        id: id ?? this.id,
        task: task ?? this.task,
        completed: completed ?? this.completed,
      );
  @override
  String toString() {
    return (StringBuffer('SubTask(')
          ..write('id: $id, ')
          ..write('task: $task, ')
          ..write('completed: $completed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id.hashCode, $mrjc(task.hashCode, completed.hashCode)));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is SubTask &&
          other.id == this.id &&
          other.task == this.task &&
          other.completed == this.completed);
}

class SubTasksCompanion extends UpdateCompanion<SubTask> {
  final Value<int> id;
  final Value<String> task;
  final Value<bool> completed;
  const SubTasksCompanion({
    this.id = const Value.absent(),
    this.task = const Value.absent(),
    this.completed = const Value.absent(),
  });
  SubTasksCompanion.insert({
    @required int id,
    @required String task,
    this.completed = const Value.absent(),
  })  : id = Value(id),
        task = Value(task);
  SubTasksCompanion copyWith(
      {Value<int> id, Value<String> task, Value<bool> completed}) {
    return SubTasksCompanion(
      id: id ?? this.id,
      task: task ?? this.task,
      completed: completed ?? this.completed,
    );
  }
}

class $SubTasksTable extends SubTasks with TableInfo<$SubTasksTable, SubTask> {
  final GeneratedDatabase _db;
  final String _alias;
  $SubTasksTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        $customConstraints: 'REFERENCES goals(id) ON DELETE CASCADE');
  }

  final VerificationMeta _taskMeta = const VerificationMeta('task');
  GeneratedTextColumn _task;
  @override
  GeneratedTextColumn get task => _task ??= _constructTask();
  GeneratedTextColumn _constructTask() {
    return GeneratedTextColumn(
      'task',
      $tableName,
      false,
    );
  }

  final VerificationMeta _completedMeta = const VerificationMeta('completed');
  GeneratedBoolColumn _completed;
  @override
  GeneratedBoolColumn get completed => _completed ??= _constructCompleted();
  GeneratedBoolColumn _constructCompleted() {
    return GeneratedBoolColumn('completed', $tableName, false,
        defaultValue: Constant(false));
  }

  @override
  List<GeneratedColumn> get $columns => [id, task, completed];
  @override
  $SubTasksTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'sub_tasks';
  @override
  final String actualTableName = 'sub_tasks';
  @override
  VerificationContext validateIntegrity(SubTasksCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.task.present) {
      context.handle(
          _taskMeta, task.isAcceptableValue(d.task.value, _taskMeta));
    } else if (task.isRequired && isInserting) {
      context.missing(_taskMeta);
    }
    if (d.completed.present) {
      context.handle(_completedMeta,
          completed.isAcceptableValue(d.completed.value, _completedMeta));
    } else if (completed.isRequired && isInserting) {
      context.missing(_completedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id, task};
  @override
  SubTask map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return SubTask.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(SubTasksCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.task.present) {
      map['task'] = Variable<String, StringType>(d.task.value);
    }
    if (d.completed.present) {
      map['completed'] = Variable<bool, BoolType>(d.completed.value);
    }
    return map;
  }

  @override
  $SubTasksTable createAlias(String alias) {
    return $SubTasksTable(_db, alias);
  }
}

class Output extends DataClass implements Insertable<Output> {
  final int id;
  final String item;
  final bool completed;
  Output({@required this.id, @required this.item, @required this.completed});
  factory Output.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    return Output(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      item: stringType.mapFromDatabaseResponse(data['${effectivePrefix}item']),
      completed:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}completed']),
    );
  }
  factory Output.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Output(
      id: serializer.fromJson<int>(json['id']),
      item: serializer.fromJson<String>(json['item']),
      completed: serializer.fromJson<bool>(json['completed']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<int>(id),
      'item': serializer.toJson<String>(item),
      'completed': serializer.toJson<bool>(completed),
    };
  }

  @override
  OutputsCompanion createCompanion(bool nullToAbsent) {
    return OutputsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      item: item == null && nullToAbsent ? const Value.absent() : Value(item),
      completed: completed == null && nullToAbsent
          ? const Value.absent()
          : Value(completed),
    );
  }

  Output copyWith({int id, String item, bool completed}) => Output(
        id: id ?? this.id,
        item: item ?? this.item,
        completed: completed ?? this.completed,
      );
  @override
  String toString() {
    return (StringBuffer('Output(')
          ..write('id: $id, ')
          ..write('item: $item, ')
          ..write('completed: $completed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id.hashCode, $mrjc(item.hashCode, completed.hashCode)));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Output &&
          other.id == this.id &&
          other.item == this.item &&
          other.completed == this.completed);
}

class OutputsCompanion extends UpdateCompanion<Output> {
  final Value<int> id;
  final Value<String> item;
  final Value<bool> completed;
  const OutputsCompanion({
    this.id = const Value.absent(),
    this.item = const Value.absent(),
    this.completed = const Value.absent(),
  });
  OutputsCompanion.insert({
    @required int id,
    @required String item,
    this.completed = const Value.absent(),
  })  : id = Value(id),
        item = Value(item);
  OutputsCompanion copyWith(
      {Value<int> id, Value<String> item, Value<bool> completed}) {
    return OutputsCompanion(
      id: id ?? this.id,
      item: item ?? this.item,
      completed: completed ?? this.completed,
    );
  }
}

class $OutputsTable extends Outputs with TableInfo<$OutputsTable, Output> {
  final GeneratedDatabase _db;
  final String _alias;
  $OutputsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        $customConstraints: 'REFERENCES goals(id) ON DELETE CASCADE');
  }

  final VerificationMeta _itemMeta = const VerificationMeta('item');
  GeneratedTextColumn _item;
  @override
  GeneratedTextColumn get item => _item ??= _constructItem();
  GeneratedTextColumn _constructItem() {
    return GeneratedTextColumn(
      'item',
      $tableName,
      false,
    );
  }

  final VerificationMeta _completedMeta = const VerificationMeta('completed');
  GeneratedBoolColumn _completed;
  @override
  GeneratedBoolColumn get completed => _completed ??= _constructCompleted();
  GeneratedBoolColumn _constructCompleted() {
    return GeneratedBoolColumn('completed', $tableName, false,
        defaultValue: Constant(false));
  }

  @override
  List<GeneratedColumn> get $columns => [id, item, completed];
  @override
  $OutputsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'outputs';
  @override
  final String actualTableName = 'outputs';
  @override
  VerificationContext validateIntegrity(OutputsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.item.present) {
      context.handle(
          _itemMeta, item.isAcceptableValue(d.item.value, _itemMeta));
    } else if (item.isRequired && isInserting) {
      context.missing(_itemMeta);
    }
    if (d.completed.present) {
      context.handle(_completedMeta,
          completed.isAcceptableValue(d.completed.value, _completedMeta));
    } else if (completed.isRequired && isInserting) {
      context.missing(_completedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id, item};
  @override
  Output map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Output.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(OutputsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.item.present) {
      map['item'] = Variable<String, StringType>(d.item.value);
    }
    if (d.completed.present) {
      map['completed'] = Variable<bool, BoolType>(d.completed.value);
    }
    return map;
  }

  @override
  $OutputsTable createAlias(String alias) {
    return $OutputsTable(_db, alias);
  }
}

class Journal extends DataClass implements Insertable<Journal> {
  final int id;
  final DateTime dateCreated;
  final String title;
  final String description;
  final String feelings;
  final String evaluation;
  final String analysis;
  final String conclusion;
  final String actionPlan;
  Journal(
      {@required this.id,
      @required this.dateCreated,
      @required this.title,
      @required this.description,
      @required this.feelings,
      @required this.evaluation,
      @required this.analysis,
      @required this.conclusion,
      @required this.actionPlan});
  factory Journal.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final stringType = db.typeSystem.forDartType<String>();
    return Journal(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      dateCreated: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}date_created']),
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      description: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      feelings: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}feelings']),
      evaluation: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}evaluation']),
      analysis: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}analysis']),
      conclusion: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}conclusion']),
      actionPlan: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}action_plan']),
    );
  }
  factory Journal.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Journal(
      id: serializer.fromJson<int>(json['id']),
      dateCreated: serializer.fromJson<DateTime>(json['dateCreated']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      feelings: serializer.fromJson<String>(json['feelings']),
      evaluation: serializer.fromJson<String>(json['evaluation']),
      analysis: serializer.fromJson<String>(json['analysis']),
      conclusion: serializer.fromJson<String>(json['conclusion']),
      actionPlan: serializer.fromJson<String>(json['actionPlan']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<int>(id),
      'dateCreated': serializer.toJson<DateTime>(dateCreated),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'feelings': serializer.toJson<String>(feelings),
      'evaluation': serializer.toJson<String>(evaluation),
      'analysis': serializer.toJson<String>(analysis),
      'conclusion': serializer.toJson<String>(conclusion),
      'actionPlan': serializer.toJson<String>(actionPlan),
    };
  }

  @override
  JournalsCompanion createCompanion(bool nullToAbsent) {
    return JournalsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      dateCreated: dateCreated == null && nullToAbsent
          ? const Value.absent()
          : Value(dateCreated),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      feelings: feelings == null && nullToAbsent
          ? const Value.absent()
          : Value(feelings),
      evaluation: evaluation == null && nullToAbsent
          ? const Value.absent()
          : Value(evaluation),
      analysis: analysis == null && nullToAbsent
          ? const Value.absent()
          : Value(analysis),
      conclusion: conclusion == null && nullToAbsent
          ? const Value.absent()
          : Value(conclusion),
      actionPlan: actionPlan == null && nullToAbsent
          ? const Value.absent()
          : Value(actionPlan),
    );
  }

  Journal copyWith(
          {int id,
          DateTime dateCreated,
          String title,
          String description,
          String feelings,
          String evaluation,
          String analysis,
          String conclusion,
          String actionPlan}) =>
      Journal(
        id: id ?? this.id,
        dateCreated: dateCreated ?? this.dateCreated,
        title: title ?? this.title,
        description: description ?? this.description,
        feelings: feelings ?? this.feelings,
        evaluation: evaluation ?? this.evaluation,
        analysis: analysis ?? this.analysis,
        conclusion: conclusion ?? this.conclusion,
        actionPlan: actionPlan ?? this.actionPlan,
      );
  @override
  String toString() {
    return (StringBuffer('Journal(')
          ..write('id: $id, ')
          ..write('dateCreated: $dateCreated, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('feelings: $feelings, ')
          ..write('evaluation: $evaluation, ')
          ..write('analysis: $analysis, ')
          ..write('conclusion: $conclusion, ')
          ..write('actionPlan: $actionPlan')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          dateCreated.hashCode,
          $mrjc(
              title.hashCode,
              $mrjc(
                  description.hashCode,
                  $mrjc(
                      feelings.hashCode,
                      $mrjc(
                          evaluation.hashCode,
                          $mrjc(
                              analysis.hashCode,
                              $mrjc(conclusion.hashCode,
                                  actionPlan.hashCode)))))))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Journal &&
          other.id == this.id &&
          other.dateCreated == this.dateCreated &&
          other.title == this.title &&
          other.description == this.description &&
          other.feelings == this.feelings &&
          other.evaluation == this.evaluation &&
          other.analysis == this.analysis &&
          other.conclusion == this.conclusion &&
          other.actionPlan == this.actionPlan);
}

class JournalsCompanion extends UpdateCompanion<Journal> {
  final Value<int> id;
  final Value<DateTime> dateCreated;
  final Value<String> title;
  final Value<String> description;
  final Value<String> feelings;
  final Value<String> evaluation;
  final Value<String> analysis;
  final Value<String> conclusion;
  final Value<String> actionPlan;
  const JournalsCompanion({
    this.id = const Value.absent(),
    this.dateCreated = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.feelings = const Value.absent(),
    this.evaluation = const Value.absent(),
    this.analysis = const Value.absent(),
    this.conclusion = const Value.absent(),
    this.actionPlan = const Value.absent(),
  });
  JournalsCompanion.insert({
    this.id = const Value.absent(),
    @required DateTime dateCreated,
    @required String title,
    @required String description,
    @required String feelings,
    @required String evaluation,
    @required String analysis,
    @required String conclusion,
    @required String actionPlan,
  })  : dateCreated = Value(dateCreated),
        title = Value(title),
        description = Value(description),
        feelings = Value(feelings),
        evaluation = Value(evaluation),
        analysis = Value(analysis),
        conclusion = Value(conclusion),
        actionPlan = Value(actionPlan);
  JournalsCompanion copyWith(
      {Value<int> id,
      Value<DateTime> dateCreated,
      Value<String> title,
      Value<String> description,
      Value<String> feelings,
      Value<String> evaluation,
      Value<String> analysis,
      Value<String> conclusion,
      Value<String> actionPlan}) {
    return JournalsCompanion(
      id: id ?? this.id,
      dateCreated: dateCreated ?? this.dateCreated,
      title: title ?? this.title,
      description: description ?? this.description,
      feelings: feelings ?? this.feelings,
      evaluation: evaluation ?? this.evaluation,
      analysis: analysis ?? this.analysis,
      conclusion: conclusion ?? this.conclusion,
      actionPlan: actionPlan ?? this.actionPlan,
    );
  }
}

class $JournalsTable extends Journals with TableInfo<$JournalsTable, Journal> {
  final GeneratedDatabase _db;
  final String _alias;
  $JournalsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _dateCreatedMeta =
      const VerificationMeta('dateCreated');
  GeneratedDateTimeColumn _dateCreated;
  @override
  GeneratedDateTimeColumn get dateCreated =>
      _dateCreated ??= _constructDateCreated();
  GeneratedDateTimeColumn _constructDateCreated() {
    return GeneratedDateTimeColumn(
      'date_created',
      $tableName,
      false,
    );
  }

  final VerificationMeta _titleMeta = const VerificationMeta('title');
  GeneratedTextColumn _title;
  @override
  GeneratedTextColumn get title => _title ??= _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn(
      'title',
      $tableName,
      false,
    );
  }

  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  GeneratedTextColumn _description;
  @override
  GeneratedTextColumn get description =>
      _description ??= _constructDescription();
  GeneratedTextColumn _constructDescription() {
    return GeneratedTextColumn(
      'description',
      $tableName,
      false,
    );
  }

  final VerificationMeta _feelingsMeta = const VerificationMeta('feelings');
  GeneratedTextColumn _feelings;
  @override
  GeneratedTextColumn get feelings => _feelings ??= _constructFeelings();
  GeneratedTextColumn _constructFeelings() {
    return GeneratedTextColumn(
      'feelings',
      $tableName,
      false,
    );
  }

  final VerificationMeta _evaluationMeta = const VerificationMeta('evaluation');
  GeneratedTextColumn _evaluation;
  @override
  GeneratedTextColumn get evaluation => _evaluation ??= _constructEvaluation();
  GeneratedTextColumn _constructEvaluation() {
    return GeneratedTextColumn(
      'evaluation',
      $tableName,
      false,
    );
  }

  final VerificationMeta _analysisMeta = const VerificationMeta('analysis');
  GeneratedTextColumn _analysis;
  @override
  GeneratedTextColumn get analysis => _analysis ??= _constructAnalysis();
  GeneratedTextColumn _constructAnalysis() {
    return GeneratedTextColumn(
      'analysis',
      $tableName,
      false,
    );
  }

  final VerificationMeta _conclusionMeta = const VerificationMeta('conclusion');
  GeneratedTextColumn _conclusion;
  @override
  GeneratedTextColumn get conclusion => _conclusion ??= _constructConclusion();
  GeneratedTextColumn _constructConclusion() {
    return GeneratedTextColumn(
      'conclusion',
      $tableName,
      false,
    );
  }

  final VerificationMeta _actionPlanMeta = const VerificationMeta('actionPlan');
  GeneratedTextColumn _actionPlan;
  @override
  GeneratedTextColumn get actionPlan => _actionPlan ??= _constructActionPlan();
  GeneratedTextColumn _constructActionPlan() {
    return GeneratedTextColumn(
      'action_plan',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        dateCreated,
        title,
        description,
        feelings,
        evaluation,
        analysis,
        conclusion,
        actionPlan
      ];
  @override
  $JournalsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'journals';
  @override
  final String actualTableName = 'journals';
  @override
  VerificationContext validateIntegrity(JournalsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.dateCreated.present) {
      context.handle(_dateCreatedMeta,
          dateCreated.isAcceptableValue(d.dateCreated.value, _dateCreatedMeta));
    } else if (dateCreated.isRequired && isInserting) {
      context.missing(_dateCreatedMeta);
    }
    if (d.title.present) {
      context.handle(
          _titleMeta, title.isAcceptableValue(d.title.value, _titleMeta));
    } else if (title.isRequired && isInserting) {
      context.missing(_titleMeta);
    }
    if (d.description.present) {
      context.handle(_descriptionMeta,
          description.isAcceptableValue(d.description.value, _descriptionMeta));
    } else if (description.isRequired && isInserting) {
      context.missing(_descriptionMeta);
    }
    if (d.feelings.present) {
      context.handle(_feelingsMeta,
          feelings.isAcceptableValue(d.feelings.value, _feelingsMeta));
    } else if (feelings.isRequired && isInserting) {
      context.missing(_feelingsMeta);
    }
    if (d.evaluation.present) {
      context.handle(_evaluationMeta,
          evaluation.isAcceptableValue(d.evaluation.value, _evaluationMeta));
    } else if (evaluation.isRequired && isInserting) {
      context.missing(_evaluationMeta);
    }
    if (d.analysis.present) {
      context.handle(_analysisMeta,
          analysis.isAcceptableValue(d.analysis.value, _analysisMeta));
    } else if (analysis.isRequired && isInserting) {
      context.missing(_analysisMeta);
    }
    if (d.conclusion.present) {
      context.handle(_conclusionMeta,
          conclusion.isAcceptableValue(d.conclusion.value, _conclusionMeta));
    } else if (conclusion.isRequired && isInserting) {
      context.missing(_conclusionMeta);
    }
    if (d.actionPlan.present) {
      context.handle(_actionPlanMeta,
          actionPlan.isAcceptableValue(d.actionPlan.value, _actionPlanMeta));
    } else if (actionPlan.isRequired && isInserting) {
      context.missing(_actionPlanMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Journal map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Journal.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(JournalsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.dateCreated.present) {
      map['date_created'] =
          Variable<DateTime, DateTimeType>(d.dateCreated.value);
    }
    if (d.title.present) {
      map['title'] = Variable<String, StringType>(d.title.value);
    }
    if (d.description.present) {
      map['description'] = Variable<String, StringType>(d.description.value);
    }
    if (d.feelings.present) {
      map['feelings'] = Variable<String, StringType>(d.feelings.value);
    }
    if (d.evaluation.present) {
      map['evaluation'] = Variable<String, StringType>(d.evaluation.value);
    }
    if (d.analysis.present) {
      map['analysis'] = Variable<String, StringType>(d.analysis.value);
    }
    if (d.conclusion.present) {
      map['conclusion'] = Variable<String, StringType>(d.conclusion.value);
    }
    if (d.actionPlan.present) {
      map['action_plan'] = Variable<String, StringType>(d.actionPlan.value);
    }
    return map;
  }

  @override
  $JournalsTable createAlias(String alias) {
    return $JournalsTable(_db, alias);
  }
}

class Listen extends DataClass implements Insertable<Listen> {
  final int id;
  final DateTime dateCreated;
  final String actName;
  final String insights;
  final bool iHad1;
  final bool iHad2;
  final bool iHad3;
  final bool iHad4;
  final bool iGave1;
  final bool iGave2;
  final bool iGave3;
  final bool iCan1;
  final bool iCan2;
  final bool ididNot1;
  final bool ididNot2;
  final bool ididNot3;
  Listen(
      {@required this.id,
      @required this.dateCreated,
      @required this.actName,
      @required this.insights,
      @required this.iHad1,
      @required this.iHad2,
      @required this.iHad3,
      @required this.iHad4,
      @required this.iGave1,
      @required this.iGave2,
      @required this.iGave3,
      @required this.iCan1,
      @required this.iCan2,
      @required this.ididNot1,
      @required this.ididNot2,
      @required this.ididNot3});
  factory Listen.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    return Listen(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      dateCreated: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}date_created']),
      actName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}act_name']),
      insights: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}insights']),
      iHad1: boolType.mapFromDatabaseResponse(data['${effectivePrefix}i_had1']),
      iHad2: boolType.mapFromDatabaseResponse(data['${effectivePrefix}i_had2']),
      iHad3: boolType.mapFromDatabaseResponse(data['${effectivePrefix}i_had3']),
      iHad4: boolType.mapFromDatabaseResponse(data['${effectivePrefix}i_had4']),
      iGave1:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}i_gave1']),
      iGave2:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}i_gave2']),
      iGave3:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}i_gave3']),
      iCan1: boolType.mapFromDatabaseResponse(data['${effectivePrefix}i_can1']),
      iCan2: boolType.mapFromDatabaseResponse(data['${effectivePrefix}i_can2']),
      ididNot1:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}idid_not1']),
      ididNot2:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}idid_not2']),
      ididNot3:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}idid_not3']),
    );
  }
  factory Listen.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Listen(
      id: serializer.fromJson<int>(json['id']),
      dateCreated: serializer.fromJson<DateTime>(json['dateCreated']),
      actName: serializer.fromJson<String>(json['actName']),
      insights: serializer.fromJson<String>(json['insights']),
      iHad1: serializer.fromJson<bool>(json['iHad1']),
      iHad2: serializer.fromJson<bool>(json['iHad2']),
      iHad3: serializer.fromJson<bool>(json['iHad3']),
      iHad4: serializer.fromJson<bool>(json['iHad4']),
      iGave1: serializer.fromJson<bool>(json['iGave1']),
      iGave2: serializer.fromJson<bool>(json['iGave2']),
      iGave3: serializer.fromJson<bool>(json['iGave3']),
      iCan1: serializer.fromJson<bool>(json['iCan1']),
      iCan2: serializer.fromJson<bool>(json['iCan2']),
      ididNot1: serializer.fromJson<bool>(json['ididNot1']),
      ididNot2: serializer.fromJson<bool>(json['ididNot2']),
      ididNot3: serializer.fromJson<bool>(json['ididNot3']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<int>(id),
      'dateCreated': serializer.toJson<DateTime>(dateCreated),
      'actName': serializer.toJson<String>(actName),
      'insights': serializer.toJson<String>(insights),
      'iHad1': serializer.toJson<bool>(iHad1),
      'iHad2': serializer.toJson<bool>(iHad2),
      'iHad3': serializer.toJson<bool>(iHad3),
      'iHad4': serializer.toJson<bool>(iHad4),
      'iGave1': serializer.toJson<bool>(iGave1),
      'iGave2': serializer.toJson<bool>(iGave2),
      'iGave3': serializer.toJson<bool>(iGave3),
      'iCan1': serializer.toJson<bool>(iCan1),
      'iCan2': serializer.toJson<bool>(iCan2),
      'ididNot1': serializer.toJson<bool>(ididNot1),
      'ididNot2': serializer.toJson<bool>(ididNot2),
      'ididNot3': serializer.toJson<bool>(ididNot3),
    };
  }

  @override
  ListensCompanion createCompanion(bool nullToAbsent) {
    return ListensCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      dateCreated: dateCreated == null && nullToAbsent
          ? const Value.absent()
          : Value(dateCreated),
      actName: actName == null && nullToAbsent
          ? const Value.absent()
          : Value(actName),
      insights: insights == null && nullToAbsent
          ? const Value.absent()
          : Value(insights),
      iHad1:
          iHad1 == null && nullToAbsent ? const Value.absent() : Value(iHad1),
      iHad2:
          iHad2 == null && nullToAbsent ? const Value.absent() : Value(iHad2),
      iHad3:
          iHad3 == null && nullToAbsent ? const Value.absent() : Value(iHad3),
      iHad4:
          iHad4 == null && nullToAbsent ? const Value.absent() : Value(iHad4),
      iGave1:
          iGave1 == null && nullToAbsent ? const Value.absent() : Value(iGave1),
      iGave2:
          iGave2 == null && nullToAbsent ? const Value.absent() : Value(iGave2),
      iGave3:
          iGave3 == null && nullToAbsent ? const Value.absent() : Value(iGave3),
      iCan1:
          iCan1 == null && nullToAbsent ? const Value.absent() : Value(iCan1),
      iCan2:
          iCan2 == null && nullToAbsent ? const Value.absent() : Value(iCan2),
      ididNot1: ididNot1 == null && nullToAbsent
          ? const Value.absent()
          : Value(ididNot1),
      ididNot2: ididNot2 == null && nullToAbsent
          ? const Value.absent()
          : Value(ididNot2),
      ididNot3: ididNot3 == null && nullToAbsent
          ? const Value.absent()
          : Value(ididNot3),
    );
  }

  Listen copyWith(
          {int id,
          DateTime dateCreated,
          String actName,
          String insights,
          bool iHad1,
          bool iHad2,
          bool iHad3,
          bool iHad4,
          bool iGave1,
          bool iGave2,
          bool iGave3,
          bool iCan1,
          bool iCan2,
          bool ididNot1,
          bool ididNot2,
          bool ididNot3}) =>
      Listen(
        id: id ?? this.id,
        dateCreated: dateCreated ?? this.dateCreated,
        actName: actName ?? this.actName,
        insights: insights ?? this.insights,
        iHad1: iHad1 ?? this.iHad1,
        iHad2: iHad2 ?? this.iHad2,
        iHad3: iHad3 ?? this.iHad3,
        iHad4: iHad4 ?? this.iHad4,
        iGave1: iGave1 ?? this.iGave1,
        iGave2: iGave2 ?? this.iGave2,
        iGave3: iGave3 ?? this.iGave3,
        iCan1: iCan1 ?? this.iCan1,
        iCan2: iCan2 ?? this.iCan2,
        ididNot1: ididNot1 ?? this.ididNot1,
        ididNot2: ididNot2 ?? this.ididNot2,
        ididNot3: ididNot3 ?? this.ididNot3,
      );
  @override
  String toString() {
    return (StringBuffer('Listen(')
          ..write('id: $id, ')
          ..write('dateCreated: $dateCreated, ')
          ..write('actName: $actName, ')
          ..write('insights: $insights, ')
          ..write('iHad1: $iHad1, ')
          ..write('iHad2: $iHad2, ')
          ..write('iHad3: $iHad3, ')
          ..write('iHad4: $iHad4, ')
          ..write('iGave1: $iGave1, ')
          ..write('iGave2: $iGave2, ')
          ..write('iGave3: $iGave3, ')
          ..write('iCan1: $iCan1, ')
          ..write('iCan2: $iCan2, ')
          ..write('ididNot1: $ididNot1, ')
          ..write('ididNot2: $ididNot2, ')
          ..write('ididNot3: $ididNot3')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          dateCreated.hashCode,
          $mrjc(
              actName.hashCode,
              $mrjc(
                  insights.hashCode,
                  $mrjc(
                      iHad1.hashCode,
                      $mrjc(
                          iHad2.hashCode,
                          $mrjc(
                              iHad3.hashCode,
                              $mrjc(
                                  iHad4.hashCode,
                                  $mrjc(
                                      iGave1.hashCode,
                                      $mrjc(
                                          iGave2.hashCode,
                                          $mrjc(
                                              iGave3.hashCode,
                                              $mrjc(
                                                  iCan1.hashCode,
                                                  $mrjc(
                                                      iCan2.hashCode,
                                                      $mrjc(
                                                          ididNot1.hashCode,
                                                          $mrjc(
                                                              ididNot2.hashCode,
                                                              ididNot3
                                                                  .hashCode))))))))))))))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Listen &&
          other.id == this.id &&
          other.dateCreated == this.dateCreated &&
          other.actName == this.actName &&
          other.insights == this.insights &&
          other.iHad1 == this.iHad1 &&
          other.iHad2 == this.iHad2 &&
          other.iHad3 == this.iHad3 &&
          other.iHad4 == this.iHad4 &&
          other.iGave1 == this.iGave1 &&
          other.iGave2 == this.iGave2 &&
          other.iGave3 == this.iGave3 &&
          other.iCan1 == this.iCan1 &&
          other.iCan2 == this.iCan2 &&
          other.ididNot1 == this.ididNot1 &&
          other.ididNot2 == this.ididNot2 &&
          other.ididNot3 == this.ididNot3);
}

class ListensCompanion extends UpdateCompanion<Listen> {
  final Value<int> id;
  final Value<DateTime> dateCreated;
  final Value<String> actName;
  final Value<String> insights;
  final Value<bool> iHad1;
  final Value<bool> iHad2;
  final Value<bool> iHad3;
  final Value<bool> iHad4;
  final Value<bool> iGave1;
  final Value<bool> iGave2;
  final Value<bool> iGave3;
  final Value<bool> iCan1;
  final Value<bool> iCan2;
  final Value<bool> ididNot1;
  final Value<bool> ididNot2;
  final Value<bool> ididNot3;
  const ListensCompanion({
    this.id = const Value.absent(),
    this.dateCreated = const Value.absent(),
    this.actName = const Value.absent(),
    this.insights = const Value.absent(),
    this.iHad1 = const Value.absent(),
    this.iHad2 = const Value.absent(),
    this.iHad3 = const Value.absent(),
    this.iHad4 = const Value.absent(),
    this.iGave1 = const Value.absent(),
    this.iGave2 = const Value.absent(),
    this.iGave3 = const Value.absent(),
    this.iCan1 = const Value.absent(),
    this.iCan2 = const Value.absent(),
    this.ididNot1 = const Value.absent(),
    this.ididNot2 = const Value.absent(),
    this.ididNot3 = const Value.absent(),
  });
  ListensCompanion.insert({
    this.id = const Value.absent(),
    @required DateTime dateCreated,
    @required String actName,
    @required String insights,
    this.iHad1 = const Value.absent(),
    this.iHad2 = const Value.absent(),
    this.iHad3 = const Value.absent(),
    this.iHad4 = const Value.absent(),
    this.iGave1 = const Value.absent(),
    this.iGave2 = const Value.absent(),
    this.iGave3 = const Value.absent(),
    this.iCan1 = const Value.absent(),
    this.iCan2 = const Value.absent(),
    this.ididNot1 = const Value.absent(),
    this.ididNot2 = const Value.absent(),
    this.ididNot3 = const Value.absent(),
  })  : dateCreated = Value(dateCreated),
        actName = Value(actName),
        insights = Value(insights);
  ListensCompanion copyWith(
      {Value<int> id,
      Value<DateTime> dateCreated,
      Value<String> actName,
      Value<String> insights,
      Value<bool> iHad1,
      Value<bool> iHad2,
      Value<bool> iHad3,
      Value<bool> iHad4,
      Value<bool> iGave1,
      Value<bool> iGave2,
      Value<bool> iGave3,
      Value<bool> iCan1,
      Value<bool> iCan2,
      Value<bool> ididNot1,
      Value<bool> ididNot2,
      Value<bool> ididNot3}) {
    return ListensCompanion(
      id: id ?? this.id,
      dateCreated: dateCreated ?? this.dateCreated,
      actName: actName ?? this.actName,
      insights: insights ?? this.insights,
      iHad1: iHad1 ?? this.iHad1,
      iHad2: iHad2 ?? this.iHad2,
      iHad3: iHad3 ?? this.iHad3,
      iHad4: iHad4 ?? this.iHad4,
      iGave1: iGave1 ?? this.iGave1,
      iGave2: iGave2 ?? this.iGave2,
      iGave3: iGave3 ?? this.iGave3,
      iCan1: iCan1 ?? this.iCan1,
      iCan2: iCan2 ?? this.iCan2,
      ididNot1: ididNot1 ?? this.ididNot1,
      ididNot2: ididNot2 ?? this.ididNot2,
      ididNot3: ididNot3 ?? this.ididNot3,
    );
  }
}

class $ListensTable extends Listens with TableInfo<$ListensTable, Listen> {
  final GeneratedDatabase _db;
  final String _alias;
  $ListensTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _dateCreatedMeta =
      const VerificationMeta('dateCreated');
  GeneratedDateTimeColumn _dateCreated;
  @override
  GeneratedDateTimeColumn get dateCreated =>
      _dateCreated ??= _constructDateCreated();
  GeneratedDateTimeColumn _constructDateCreated() {
    return GeneratedDateTimeColumn(
      'date_created',
      $tableName,
      false,
    );
  }

  final VerificationMeta _actNameMeta = const VerificationMeta('actName');
  GeneratedTextColumn _actName;
  @override
  GeneratedTextColumn get actName => _actName ??= _constructActName();
  GeneratedTextColumn _constructActName() {
    return GeneratedTextColumn(
      'act_name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _insightsMeta = const VerificationMeta('insights');
  GeneratedTextColumn _insights;
  @override
  GeneratedTextColumn get insights => _insights ??= _constructInsights();
  GeneratedTextColumn _constructInsights() {
    return GeneratedTextColumn(
      'insights',
      $tableName,
      false,
    );
  }

  final VerificationMeta _iHad1Meta = const VerificationMeta('iHad1');
  GeneratedBoolColumn _iHad1;
  @override
  GeneratedBoolColumn get iHad1 => _iHad1 ??= _constructIHad1();
  GeneratedBoolColumn _constructIHad1() {
    return GeneratedBoolColumn('i_had1', $tableName, false,
        defaultValue: Constant(false));
  }

  final VerificationMeta _iHad2Meta = const VerificationMeta('iHad2');
  GeneratedBoolColumn _iHad2;
  @override
  GeneratedBoolColumn get iHad2 => _iHad2 ??= _constructIHad2();
  GeneratedBoolColumn _constructIHad2() {
    return GeneratedBoolColumn('i_had2', $tableName, false,
        defaultValue: Constant(false));
  }

  final VerificationMeta _iHad3Meta = const VerificationMeta('iHad3');
  GeneratedBoolColumn _iHad3;
  @override
  GeneratedBoolColumn get iHad3 => _iHad3 ??= _constructIHad3();
  GeneratedBoolColumn _constructIHad3() {
    return GeneratedBoolColumn('i_had3', $tableName, false,
        defaultValue: Constant(false));
  }

  final VerificationMeta _iHad4Meta = const VerificationMeta('iHad4');
  GeneratedBoolColumn _iHad4;
  @override
  GeneratedBoolColumn get iHad4 => _iHad4 ??= _constructIHad4();
  GeneratedBoolColumn _constructIHad4() {
    return GeneratedBoolColumn('i_had4', $tableName, false,
        defaultValue: Constant(false));
  }

  final VerificationMeta _iGave1Meta = const VerificationMeta('iGave1');
  GeneratedBoolColumn _iGave1;
  @override
  GeneratedBoolColumn get iGave1 => _iGave1 ??= _constructIGave1();
  GeneratedBoolColumn _constructIGave1() {
    return GeneratedBoolColumn('i_gave1', $tableName, false,
        defaultValue: Constant(false));
  }

  final VerificationMeta _iGave2Meta = const VerificationMeta('iGave2');
  GeneratedBoolColumn _iGave2;
  @override
  GeneratedBoolColumn get iGave2 => _iGave2 ??= _constructIGave2();
  GeneratedBoolColumn _constructIGave2() {
    return GeneratedBoolColumn('i_gave2', $tableName, false,
        defaultValue: Constant(false));
  }

  final VerificationMeta _iGave3Meta = const VerificationMeta('iGave3');
  GeneratedBoolColumn _iGave3;
  @override
  GeneratedBoolColumn get iGave3 => _iGave3 ??= _constructIGave3();
  GeneratedBoolColumn _constructIGave3() {
    return GeneratedBoolColumn('i_gave3', $tableName, false,
        defaultValue: Constant(false));
  }

  final VerificationMeta _iCan1Meta = const VerificationMeta('iCan1');
  GeneratedBoolColumn _iCan1;
  @override
  GeneratedBoolColumn get iCan1 => _iCan1 ??= _constructICan1();
  GeneratedBoolColumn _constructICan1() {
    return GeneratedBoolColumn('i_can1', $tableName, false,
        defaultValue: Constant(false));
  }

  final VerificationMeta _iCan2Meta = const VerificationMeta('iCan2');
  GeneratedBoolColumn _iCan2;
  @override
  GeneratedBoolColumn get iCan2 => _iCan2 ??= _constructICan2();
  GeneratedBoolColumn _constructICan2() {
    return GeneratedBoolColumn('i_can2', $tableName, false,
        defaultValue: Constant(false));
  }

  final VerificationMeta _ididNot1Meta = const VerificationMeta('ididNot1');
  GeneratedBoolColumn _ididNot1;
  @override
  GeneratedBoolColumn get ididNot1 => _ididNot1 ??= _constructIdidNot1();
  GeneratedBoolColumn _constructIdidNot1() {
    return GeneratedBoolColumn('idid_not1', $tableName, false,
        defaultValue: Constant(false));
  }

  final VerificationMeta _ididNot2Meta = const VerificationMeta('ididNot2');
  GeneratedBoolColumn _ididNot2;
  @override
  GeneratedBoolColumn get ididNot2 => _ididNot2 ??= _constructIdidNot2();
  GeneratedBoolColumn _constructIdidNot2() {
    return GeneratedBoolColumn('idid_not2', $tableName, false,
        defaultValue: Constant(false));
  }

  final VerificationMeta _ididNot3Meta = const VerificationMeta('ididNot3');
  GeneratedBoolColumn _ididNot3;
  @override
  GeneratedBoolColumn get ididNot3 => _ididNot3 ??= _constructIdidNot3();
  GeneratedBoolColumn _constructIdidNot3() {
    return GeneratedBoolColumn('idid_not3', $tableName, false,
        defaultValue: Constant(false));
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        dateCreated,
        actName,
        insights,
        iHad1,
        iHad2,
        iHad3,
        iHad4,
        iGave1,
        iGave2,
        iGave3,
        iCan1,
        iCan2,
        ididNot1,
        ididNot2,
        ididNot3
      ];
  @override
  $ListensTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'listens';
  @override
  final String actualTableName = 'listens';
  @override
  VerificationContext validateIntegrity(ListensCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.dateCreated.present) {
      context.handle(_dateCreatedMeta,
          dateCreated.isAcceptableValue(d.dateCreated.value, _dateCreatedMeta));
    } else if (dateCreated.isRequired && isInserting) {
      context.missing(_dateCreatedMeta);
    }
    if (d.actName.present) {
      context.handle(_actNameMeta,
          actName.isAcceptableValue(d.actName.value, _actNameMeta));
    } else if (actName.isRequired && isInserting) {
      context.missing(_actNameMeta);
    }
    if (d.insights.present) {
      context.handle(_insightsMeta,
          insights.isAcceptableValue(d.insights.value, _insightsMeta));
    } else if (insights.isRequired && isInserting) {
      context.missing(_insightsMeta);
    }
    if (d.iHad1.present) {
      context.handle(
          _iHad1Meta, iHad1.isAcceptableValue(d.iHad1.value, _iHad1Meta));
    } else if (iHad1.isRequired && isInserting) {
      context.missing(_iHad1Meta);
    }
    if (d.iHad2.present) {
      context.handle(
          _iHad2Meta, iHad2.isAcceptableValue(d.iHad2.value, _iHad2Meta));
    } else if (iHad2.isRequired && isInserting) {
      context.missing(_iHad2Meta);
    }
    if (d.iHad3.present) {
      context.handle(
          _iHad3Meta, iHad3.isAcceptableValue(d.iHad3.value, _iHad3Meta));
    } else if (iHad3.isRequired && isInserting) {
      context.missing(_iHad3Meta);
    }
    if (d.iHad4.present) {
      context.handle(
          _iHad4Meta, iHad4.isAcceptableValue(d.iHad4.value, _iHad4Meta));
    } else if (iHad4.isRequired && isInserting) {
      context.missing(_iHad4Meta);
    }
    if (d.iGave1.present) {
      context.handle(
          _iGave1Meta, iGave1.isAcceptableValue(d.iGave1.value, _iGave1Meta));
    } else if (iGave1.isRequired && isInserting) {
      context.missing(_iGave1Meta);
    }
    if (d.iGave2.present) {
      context.handle(
          _iGave2Meta, iGave2.isAcceptableValue(d.iGave2.value, _iGave2Meta));
    } else if (iGave2.isRequired && isInserting) {
      context.missing(_iGave2Meta);
    }
    if (d.iGave3.present) {
      context.handle(
          _iGave3Meta, iGave3.isAcceptableValue(d.iGave3.value, _iGave3Meta));
    } else if (iGave3.isRequired && isInserting) {
      context.missing(_iGave3Meta);
    }
    if (d.iCan1.present) {
      context.handle(
          _iCan1Meta, iCan1.isAcceptableValue(d.iCan1.value, _iCan1Meta));
    } else if (iCan1.isRequired && isInserting) {
      context.missing(_iCan1Meta);
    }
    if (d.iCan2.present) {
      context.handle(
          _iCan2Meta, iCan2.isAcceptableValue(d.iCan2.value, _iCan2Meta));
    } else if (iCan2.isRequired && isInserting) {
      context.missing(_iCan2Meta);
    }
    if (d.ididNot1.present) {
      context.handle(_ididNot1Meta,
          ididNot1.isAcceptableValue(d.ididNot1.value, _ididNot1Meta));
    } else if (ididNot1.isRequired && isInserting) {
      context.missing(_ididNot1Meta);
    }
    if (d.ididNot2.present) {
      context.handle(_ididNot2Meta,
          ididNot2.isAcceptableValue(d.ididNot2.value, _ididNot2Meta));
    } else if (ididNot2.isRequired && isInserting) {
      context.missing(_ididNot2Meta);
    }
    if (d.ididNot3.present) {
      context.handle(_ididNot3Meta,
          ididNot3.isAcceptableValue(d.ididNot3.value, _ididNot3Meta));
    } else if (ididNot3.isRequired && isInserting) {
      context.missing(_ididNot3Meta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Listen map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Listen.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(ListensCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.dateCreated.present) {
      map['date_created'] =
          Variable<DateTime, DateTimeType>(d.dateCreated.value);
    }
    if (d.actName.present) {
      map['act_name'] = Variable<String, StringType>(d.actName.value);
    }
    if (d.insights.present) {
      map['insights'] = Variable<String, StringType>(d.insights.value);
    }
    if (d.iHad1.present) {
      map['i_had1'] = Variable<bool, BoolType>(d.iHad1.value);
    }
    if (d.iHad2.present) {
      map['i_had2'] = Variable<bool, BoolType>(d.iHad2.value);
    }
    if (d.iHad3.present) {
      map['i_had3'] = Variable<bool, BoolType>(d.iHad3.value);
    }
    if (d.iHad4.present) {
      map['i_had4'] = Variable<bool, BoolType>(d.iHad4.value);
    }
    if (d.iGave1.present) {
      map['i_gave1'] = Variable<bool, BoolType>(d.iGave1.value);
    }
    if (d.iGave2.present) {
      map['i_gave2'] = Variable<bool, BoolType>(d.iGave2.value);
    }
    if (d.iGave3.present) {
      map['i_gave3'] = Variable<bool, BoolType>(d.iGave3.value);
    }
    if (d.iCan1.present) {
      map['i_can1'] = Variable<bool, BoolType>(d.iCan1.value);
    }
    if (d.iCan2.present) {
      map['i_can2'] = Variable<bool, BoolType>(d.iCan2.value);
    }
    if (d.ididNot1.present) {
      map['idid_not1'] = Variable<bool, BoolType>(d.ididNot1.value);
    }
    if (d.ididNot2.present) {
      map['idid_not2'] = Variable<bool, BoolType>(d.ididNot2.value);
    }
    if (d.ididNot3.present) {
      map['idid_not3'] = Variable<bool, BoolType>(d.ididNot3.value);
    }
    return map;
  }

  @override
  $ListensTable createAlias(String alias) {
    return $ListensTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $GoalsTable _goals;
  $GoalsTable get goals => _goals ??= $GoalsTable(this);
  $SubTasksTable _subTasks;
  $SubTasksTable get subTasks => _subTasks ??= $SubTasksTable(this);
  $OutputsTable _outputs;
  $OutputsTable get outputs => _outputs ??= $OutputsTable(this);
  $JournalsTable _journals;
  $JournalsTable get journals => _journals ??= $JournalsTable(this);
  $ListensTable _listens;
  $ListensTable get listens => _listens ??= $ListensTable(this);
  GoalDao _goalDao;
  GoalDao get goalDao => _goalDao ??= GoalDao(this as AppDatabase);
  SubTaskDao _subTaskDao;
  SubTaskDao get subTaskDao => _subTaskDao ??= SubTaskDao(this as AppDatabase);
  OutputDao _outputDao;
  OutputDao get outputDao => _outputDao ??= OutputDao(this as AppDatabase);
  JournalDao _journalDao;
  JournalDao get journalDao => _journalDao ??= JournalDao(this as AppDatabase);
  ListenDao _listenDao;
  ListenDao get listenDao => _listenDao ??= ListenDao(this as AppDatabase);
  @override
  List<TableInfo> get allTables =>
      [goals, subTasks, outputs, journals, listens];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$GoalDaoMixin on DatabaseAccessor<AppDatabase> {
  $GoalsTable get goals => db.goals;
  $SubTasksTable get subTasks => db.subTasks;
  $OutputsTable get outputs => db.outputs;
}
mixin _$JournalDaoMixin on DatabaseAccessor<AppDatabase> {
  $JournalsTable get journals => db.journals;
}
mixin _$ListenDaoMixin on DatabaseAccessor<AppDatabase> {
  $ListensTable get listens => db.listens;
}
mixin _$SubTaskDaoMixin on DatabaseAccessor<AppDatabase> {
  $SubTasksTable get subTasks => db.subTasks;
}
mixin _$OutputDaoMixin on DatabaseAccessor<AppDatabase> {
  $OutputsTable get outputs => db.outputs;
}
