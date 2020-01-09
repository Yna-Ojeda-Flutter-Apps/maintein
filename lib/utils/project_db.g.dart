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

class Assessment extends DataClass implements Insertable<Assessment> {
  final int id;
  final bool isMWB;
  final DateTime dateCreated;
  Assessment(
      {@required this.id, @required this.isMWB, @required this.dateCreated});
  factory Assessment.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final boolType = db.typeSystem.forDartType<bool>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Assessment(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      isMWB:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}is_m_w_b']),
      dateCreated: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}date_created']),
    );
  }
  factory Assessment.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Assessment(
      id: serializer.fromJson<int>(json['id']),
      isMWB: serializer.fromJson<bool>(json['isMWB']),
      dateCreated: serializer.fromJson<DateTime>(json['dateCreated']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<int>(id),
      'isMWB': serializer.toJson<bool>(isMWB),
      'dateCreated': serializer.toJson<DateTime>(dateCreated),
    };
  }

  @override
  AssessmentsCompanion createCompanion(bool nullToAbsent) {
    return AssessmentsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      isMWB:
          isMWB == null && nullToAbsent ? const Value.absent() : Value(isMWB),
      dateCreated: dateCreated == null && nullToAbsent
          ? const Value.absent()
          : Value(dateCreated),
    );
  }

  Assessment copyWith({int id, bool isMWB, DateTime dateCreated}) => Assessment(
        id: id ?? this.id,
        isMWB: isMWB ?? this.isMWB,
        dateCreated: dateCreated ?? this.dateCreated,
      );
  @override
  String toString() {
    return (StringBuffer('Assessment(')
          ..write('id: $id, ')
          ..write('isMWB: $isMWB, ')
          ..write('dateCreated: $dateCreated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id.hashCode, $mrjc(isMWB.hashCode, dateCreated.hashCode)));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Assessment &&
          other.id == this.id &&
          other.isMWB == this.isMWB &&
          other.dateCreated == this.dateCreated);
}

class AssessmentsCompanion extends UpdateCompanion<Assessment> {
  final Value<int> id;
  final Value<bool> isMWB;
  final Value<DateTime> dateCreated;
  const AssessmentsCompanion({
    this.id = const Value.absent(),
    this.isMWB = const Value.absent(),
    this.dateCreated = const Value.absent(),
  });
  AssessmentsCompanion.insert({
    this.id = const Value.absent(),
    this.isMWB = const Value.absent(),
    this.dateCreated = const Value.absent(),
  });
  AssessmentsCompanion copyWith(
      {Value<int> id, Value<bool> isMWB, Value<DateTime> dateCreated}) {
    return AssessmentsCompanion(
      id: id ?? this.id,
      isMWB: isMWB ?? this.isMWB,
      dateCreated: dateCreated ?? this.dateCreated,
    );
  }
}

class $AssessmentsTable extends Assessments
    with TableInfo<$AssessmentsTable, Assessment> {
  final GeneratedDatabase _db;
  final String _alias;
  $AssessmentsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _isMWBMeta = const VerificationMeta('isMWB');
  GeneratedBoolColumn _isMWB;
  @override
  GeneratedBoolColumn get isMWB => _isMWB ??= _constructIsMWB();
  GeneratedBoolColumn _constructIsMWB() {
    return GeneratedBoolColumn('is_m_w_b', $tableName, false,
        defaultValue: Constant(true));
  }

  final VerificationMeta _dateCreatedMeta =
      const VerificationMeta('dateCreated');
  GeneratedDateTimeColumn _dateCreated;
  @override
  GeneratedDateTimeColumn get dateCreated =>
      _dateCreated ??= _constructDateCreated();
  GeneratedDateTimeColumn _constructDateCreated() {
    return GeneratedDateTimeColumn('date_created', $tableName, false,
        defaultValue: Constant(DateTime.now()));
  }

  @override
  List<GeneratedColumn> get $columns => [id, isMWB, dateCreated];
  @override
  $AssessmentsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'assessments';
  @override
  final String actualTableName = 'assessments';
  @override
  VerificationContext validateIntegrity(AssessmentsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.isMWB.present) {
      context.handle(
          _isMWBMeta, isMWB.isAcceptableValue(d.isMWB.value, _isMWBMeta));
    } else if (isMWB.isRequired && isInserting) {
      context.missing(_isMWBMeta);
    }
    if (d.dateCreated.present) {
      context.handle(_dateCreatedMeta,
          dateCreated.isAcceptableValue(d.dateCreated.value, _dateCreatedMeta));
    } else if (dateCreated.isRequired && isInserting) {
      context.missing(_dateCreatedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Assessment map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Assessment.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(AssessmentsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.isMWB.present) {
      map['is_m_w_b'] = Variable<bool, BoolType>(d.isMWB.value);
    }
    if (d.dateCreated.present) {
      map['date_created'] =
          Variable<DateTime, DateTimeType>(d.dateCreated.value);
    }
    return map;
  }

  @override
  $AssessmentsTable createAlias(String alias) {
    return $AssessmentsTable(_db, alias);
  }
}

class Question extends DataClass implements Insertable<Question> {
  final int id;
  final int qId;
  final int score;
  Question({@required this.id, @required this.qId, @required this.score});
  factory Question.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    return Question(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      qId: intType.mapFromDatabaseResponse(data['${effectivePrefix}q_id']),
      score: intType.mapFromDatabaseResponse(data['${effectivePrefix}score']),
    );
  }
  factory Question.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Question(
      id: serializer.fromJson<int>(json['id']),
      qId: serializer.fromJson<int>(json['qId']),
      score: serializer.fromJson<int>(json['score']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<int>(id),
      'qId': serializer.toJson<int>(qId),
      'score': serializer.toJson<int>(score),
    };
  }

  @override
  QuestionsCompanion createCompanion(bool nullToAbsent) {
    return QuestionsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      qId: qId == null && nullToAbsent ? const Value.absent() : Value(qId),
      score:
          score == null && nullToAbsent ? const Value.absent() : Value(score),
    );
  }

  Question copyWith({int id, int qId, int score}) => Question(
        id: id ?? this.id,
        qId: qId ?? this.qId,
        score: score ?? this.score,
      );
  @override
  String toString() {
    return (StringBuffer('Question(')
          ..write('id: $id, ')
          ..write('qId: $qId, ')
          ..write('score: $score')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id.hashCode, $mrjc(qId.hashCode, score.hashCode)));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Question &&
          other.id == this.id &&
          other.qId == this.qId &&
          other.score == this.score);
}

class QuestionsCompanion extends UpdateCompanion<Question> {
  final Value<int> id;
  final Value<int> qId;
  final Value<int> score;
  const QuestionsCompanion({
    this.id = const Value.absent(),
    this.qId = const Value.absent(),
    this.score = const Value.absent(),
  });
  QuestionsCompanion.insert({
    @required int id,
    @required int qId,
    this.score = const Value.absent(),
  })  : id = Value(id),
        qId = Value(qId);
  QuestionsCompanion copyWith(
      {Value<int> id, Value<int> qId, Value<int> score}) {
    return QuestionsCompanion(
      id: id ?? this.id,
      qId: qId ?? this.qId,
      score: score ?? this.score,
    );
  }
}

class $QuestionsTable extends Questions
    with TableInfo<$QuestionsTable, Question> {
  final GeneratedDatabase _db;
  final String _alias;
  $QuestionsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        $customConstraints: 'REFERENCES assessments(id) ON DELETE CASCADE');
  }

  final VerificationMeta _qIdMeta = const VerificationMeta('qId');
  GeneratedIntColumn _qId;
  @override
  GeneratedIntColumn get qId => _qId ??= _constructQId();
  GeneratedIntColumn _constructQId() {
    return GeneratedIntColumn(
      'q_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _scoreMeta = const VerificationMeta('score');
  GeneratedIntColumn _score;
  @override
  GeneratedIntColumn get score => _score ??= _constructScore();
  GeneratedIntColumn _constructScore() {
    return GeneratedIntColumn('score', $tableName, false,
        defaultValue: Constant(0));
  }

  @override
  List<GeneratedColumn> get $columns => [id, qId, score];
  @override
  $QuestionsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'questions';
  @override
  final String actualTableName = 'questions';
  @override
  VerificationContext validateIntegrity(QuestionsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.qId.present) {
      context.handle(_qIdMeta, qId.isAcceptableValue(d.qId.value, _qIdMeta));
    } else if (qId.isRequired && isInserting) {
      context.missing(_qIdMeta);
    }
    if (d.score.present) {
      context.handle(
          _scoreMeta, score.isAcceptableValue(d.score.value, _scoreMeta));
    } else if (score.isRequired && isInserting) {
      context.missing(_scoreMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id, qId};
  @override
  Question map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Question.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(QuestionsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.qId.present) {
      map['q_id'] = Variable<int, IntType>(d.qId.value);
    }
    if (d.score.present) {
      map['score'] = Variable<int, IntType>(d.score.value);
    }
    return map;
  }

  @override
  $QuestionsTable createAlias(String alias) {
    return $QuestionsTable(_db, alias);
  }
}

class Listen extends DataClass implements Insertable<Listen> {
  final int id;
  final DateTime dateCreated;
  final String actName;
  final String insights;
  Listen(
      {@required this.id,
      @required this.dateCreated,
      @required this.actName,
      @required this.insights});
  factory Listen.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final stringType = db.typeSystem.forDartType<String>();
    return Listen(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      dateCreated: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}date_created']),
      actName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}act_name']),
      insights: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}insights']),
    );
  }
  factory Listen.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Listen(
      id: serializer.fromJson<int>(json['id']),
      dateCreated: serializer.fromJson<DateTime>(json['dateCreated']),
      actName: serializer.fromJson<String>(json['actName']),
      insights: serializer.fromJson<String>(json['insights']),
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
    );
  }

  Listen copyWith(
          {int id, DateTime dateCreated, String actName, String insights}) =>
      Listen(
        id: id ?? this.id,
        dateCreated: dateCreated ?? this.dateCreated,
        actName: actName ?? this.actName,
        insights: insights ?? this.insights,
      );
  @override
  String toString() {
    return (StringBuffer('Listen(')
          ..write('id: $id, ')
          ..write('dateCreated: $dateCreated, ')
          ..write('actName: $actName, ')
          ..write('insights: $insights')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(dateCreated.hashCode, $mrjc(actName.hashCode, insights.hashCode))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Listen &&
          other.id == this.id &&
          other.dateCreated == this.dateCreated &&
          other.actName == this.actName &&
          other.insights == this.insights);
}

class ListensCompanion extends UpdateCompanion<Listen> {
  final Value<int> id;
  final Value<DateTime> dateCreated;
  final Value<String> actName;
  final Value<String> insights;
  const ListensCompanion({
    this.id = const Value.absent(),
    this.dateCreated = const Value.absent(),
    this.actName = const Value.absent(),
    this.insights = const Value.absent(),
  });
  ListensCompanion.insert({
    this.id = const Value.absent(),
    this.dateCreated = const Value.absent(),
    @required String actName,
    @required String insights,
  })  : actName = Value(actName),
        insights = Value(insights);
  ListensCompanion copyWith(
      {Value<int> id,
      Value<DateTime> dateCreated,
      Value<String> actName,
      Value<String> insights}) {
    return ListensCompanion(
      id: id ?? this.id,
      dateCreated: dateCreated ?? this.dateCreated,
      actName: actName ?? this.actName,
      insights: insights ?? this.insights,
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
    return GeneratedDateTimeColumn('date_created', $tableName, false,
        defaultValue: Constant(DateTime.now()));
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

  @override
  List<GeneratedColumn> get $columns => [id, dateCreated, actName, insights];
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
    return map;
  }

  @override
  $ListensTable createAlias(String alias) {
    return $ListensTable(_db, alias);
  }
}

class Desc extends DataClass implements Insertable<Desc> {
  final int id;
  final int cId;
  final bool charVal;
  Desc({@required this.id, @required this.cId, @required this.charVal});
  factory Desc.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final boolType = db.typeSystem.forDartType<bool>();
    return Desc(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      cId: intType.mapFromDatabaseResponse(data['${effectivePrefix}c_id']),
      charVal:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}char_val']),
    );
  }
  factory Desc.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Desc(
      id: serializer.fromJson<int>(json['id']),
      cId: serializer.fromJson<int>(json['cId']),
      charVal: serializer.fromJson<bool>(json['charVal']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<int>(id),
      'cId': serializer.toJson<int>(cId),
      'charVal': serializer.toJson<bool>(charVal),
    };
  }

  @override
  DescsCompanion createCompanion(bool nullToAbsent) {
    return DescsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      cId: cId == null && nullToAbsent ? const Value.absent() : Value(cId),
      charVal: charVal == null && nullToAbsent
          ? const Value.absent()
          : Value(charVal),
    );
  }

  Desc copyWith({int id, int cId, bool charVal}) => Desc(
        id: id ?? this.id,
        cId: cId ?? this.cId,
        charVal: charVal ?? this.charVal,
      );
  @override
  String toString() {
    return (StringBuffer('Desc(')
          ..write('id: $id, ')
          ..write('cId: $cId, ')
          ..write('charVal: $charVal')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id.hashCode, $mrjc(cId.hashCode, charVal.hashCode)));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Desc &&
          other.id == this.id &&
          other.cId == this.cId &&
          other.charVal == this.charVal);
}

class DescsCompanion extends UpdateCompanion<Desc> {
  final Value<int> id;
  final Value<int> cId;
  final Value<bool> charVal;
  const DescsCompanion({
    this.id = const Value.absent(),
    this.cId = const Value.absent(),
    this.charVal = const Value.absent(),
  });
  DescsCompanion.insert({
    @required int id,
    @required int cId,
    this.charVal = const Value.absent(),
  })  : id = Value(id),
        cId = Value(cId);
  DescsCompanion copyWith(
      {Value<int> id, Value<int> cId, Value<bool> charVal}) {
    return DescsCompanion(
      id: id ?? this.id,
      cId: cId ?? this.cId,
      charVal: charVal ?? this.charVal,
    );
  }
}

class $DescsTable extends Descs with TableInfo<$DescsTable, Desc> {
  final GeneratedDatabase _db;
  final String _alias;
  $DescsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        $customConstraints: 'REFERENCES listens(id) ON DELETE CASCADE');
  }

  final VerificationMeta _cIdMeta = const VerificationMeta('cId');
  GeneratedIntColumn _cId;
  @override
  GeneratedIntColumn get cId => _cId ??= _constructCId();
  GeneratedIntColumn _constructCId() {
    return GeneratedIntColumn(
      'c_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _charValMeta = const VerificationMeta('charVal');
  GeneratedBoolColumn _charVal;
  @override
  GeneratedBoolColumn get charVal => _charVal ??= _constructCharVal();
  GeneratedBoolColumn _constructCharVal() {
    return GeneratedBoolColumn('char_val', $tableName, false,
        defaultValue: Constant(false));
  }

  @override
  List<GeneratedColumn> get $columns => [id, cId, charVal];
  @override
  $DescsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'descs';
  @override
  final String actualTableName = 'descs';
  @override
  VerificationContext validateIntegrity(DescsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.cId.present) {
      context.handle(_cIdMeta, cId.isAcceptableValue(d.cId.value, _cIdMeta));
    } else if (cId.isRequired && isInserting) {
      context.missing(_cIdMeta);
    }
    if (d.charVal.present) {
      context.handle(_charValMeta,
          charVal.isAcceptableValue(d.charVal.value, _charValMeta));
    } else if (charVal.isRequired && isInserting) {
      context.missing(_charValMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id, cId};
  @override
  Desc map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Desc.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(DescsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.cId.present) {
      map['c_id'] = Variable<int, IntType>(d.cId.value);
    }
    if (d.charVal.present) {
      map['char_val'] = Variable<bool, BoolType>(d.charVal.value);
    }
    return map;
  }

  @override
  $DescsTable createAlias(String alias) {
    return $DescsTable(_db, alias);
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
  $AssessmentsTable _assessments;
  $AssessmentsTable get assessments => _assessments ??= $AssessmentsTable(this);
  $QuestionsTable _questions;
  $QuestionsTable get questions => _questions ??= $QuestionsTable(this);
  $ListensTable _listens;
  $ListensTable get listens => _listens ??= $ListensTable(this);
  $DescsTable _descs;
  $DescsTable get descs => _descs ??= $DescsTable(this);
  GoalDao _goalDao;
  GoalDao get goalDao => _goalDao ??= GoalDao(this as AppDatabase);
  SubTaskDao _subTaskDao;
  SubTaskDao get subTaskDao => _subTaskDao ??= SubTaskDao(this as AppDatabase);
  OutputDao _outputDao;
  OutputDao get outputDao => _outputDao ??= OutputDao(this as AppDatabase);
  JournalDao _journalDao;
  JournalDao get journalDao => _journalDao ??= JournalDao(this as AppDatabase);
  AssessmentDao _assessmentDao;
  AssessmentDao get assessmentDao =>
      _assessmentDao ??= AssessmentDao(this as AppDatabase);
  ListenDao _listenDao;
  ListenDao get listenDao => _listenDao ??= ListenDao(this as AppDatabase);
  @override
  List<TableInfo> get allTables => [
        goals,
        subTasks,
        outputs,
        journals,
        assessments,
        questions,
        listens,
        descs
      ];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$GoalDaoMixin on DatabaseAccessor<AppDatabase> {
  $GoalsTable get goals => db.goals;
  $SubTasksTable get subTasks => db.subTasks;
  $OutputsTable get outputs => db.outputs;
}
mixin _$SubTaskDaoMixin on DatabaseAccessor<AppDatabase> {
  $SubTasksTable get subTasks => db.subTasks;
}
mixin _$OutputDaoMixin on DatabaseAccessor<AppDatabase> {
  $OutputsTable get outputs => db.outputs;
}
mixin _$JournalDaoMixin on DatabaseAccessor<AppDatabase> {
  $JournalsTable get journals => db.journals;
}
mixin _$AssessmentDaoMixin on DatabaseAccessor<AppDatabase> {
  $AssessmentsTable get assessments => db.assessments;
  $QuestionsTable get questions => db.questions;
}
mixin _$ListenDaoMixin on DatabaseAccessor<AppDatabase> {
  $ListensTable get listens => db.listens;
  $DescsTable get descs => db.descs;
}
