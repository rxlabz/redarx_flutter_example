import 'dart:async';
import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:http/http.dart';
import 'package:redarx/redarx.dart';
import 'package:redarx_flutter_example/values/serializers.dart';
import 'package:redarx_flutter_example/values/todo.dart';
import 'package:redarx_flutter_example/values/todomodel.dart';

/// async json loader
class AsyncLoadAllCommand extends AsyncCommand<TodoModel> {
  AsyncLoadAllCommand(this.path);

  String path;

  TodoModel _lastState;

  TodoModel get lastState => _lastState;

  final standardSerializers =
      (serializers.toBuilder()..addPlugin(new StandardJsonPlugin())).build();

  @override
  Future<TodoModel> execAsync(TodoModel model) async {
    BuiltList<Todo> todos = await loadAll();
    model = new TodoModel((b) => b
      ..allTodos = todos.toBuilder()
      ..showCompleted = model.showCompleted);
    _lastState = model;
    return model;
  }

  Future<BuiltList<Todo>> loadAll() async {
    final rawTodos = (await get(path)).body;
    final todos = JSON.decode(rawTodos)['todos'] as List<dynamic>;
    return new BuiltList<Todo>(todos.map((d) => new Todo.fromMap(d)).toList());
  }

  static AsyncCommandBuilder constructor(path) {
    return ([t]) => new AsyncLoadAllCommand(path);
  }
}

/// add a new task
class AddTodoCommand extends Command<TodoModel> {
  Todo todo;

  AddTodoCommand(this.todo);

  @override
  TodoModel exec(TodoModel model) => new TodoModel((b) => b
    ..allTodos = model.allTodos.rebuild((b) => b.add(todo)).toBuilder()
    ..showCompleted = false);

  static CommandBuilder constructor() {
    return ([Todo todo]) => new AddTodoCommand(todo);
  }
}

/// change task state
class UpdateTodoCommand extends Command<TodoModel> {
  Todo todo;

  UpdateTodoCommand(this.todo);

  @override
  TodoModel exec(TodoModel model) {
    final updated = model.allTodos.singleWhere((t) => t.id == todo.id);
    final updatedIndex = model.allTodos.indexOf(updated);
    return new TodoModel((b) => b
      ..allTodos = model.allTodos
          .rebuild(
              (b) => b.replaceRange(updatedIndex, updatedIndex + 1, [todo]))
          .toBuilder()
      ..showCompleted = model.showCompleted);
  }

  static CommandBuilder constructor() {
    return ([Todo todo]) => new UpdateTodoCommand(todo);
  }
}

/// remove completed tasks from archives
class ClearArchivesCommand extends Command<TodoModel> {
  @override
  TodoModel exec(TodoModel model) => new TodoModel((b) => b
    ..allTodos =
        model.allTodos.rebuild((b) => b.where((t) => !t.completed)).toBuilder()
    ..showCompleted = model.showCompleted);

  static CommandBuilder constructor() {
    return ([t]) => new ClearArchivesCommand();
  }
}

/// complete all tasks
class CompleteAllCommand extends Command<TodoModel> {
  @override
  TodoModel exec(TodoModel model) => new TodoModel((b) => b
    ..allTodos = model.allTodos
        .rebuild((b) => b.map(
              (item) => new Todo((b) => b
                ..label = item.label
                ..completed = true
                ..id = item.id),
            ))
        .toBuilder()
    ..showCompleted = model.showCompleted);

  static CommandBuilder constructor() {
    return ([t]) => new CompleteAllCommand();
  }
}

/// toggle view remaining | completed
class ToggleShowArchivesCommand extends Command<TodoModel> {
  @override
  TodoModel exec(TodoModel model) => new TodoModel((b) => b
    ..allTodos = model.allTodos.toBuilder()
    ..showCompleted = !model.showCompleted);

  static CommandBuilder constructor() {
    return ([t]) => new ToggleShowArchivesCommand();
  }
}
