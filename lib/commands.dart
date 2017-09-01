import 'dart:async';
import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:redarx/redarx.dart';
import 'package:redarx_flutter_example/model/model.dart';
import 'package:redarx_flutter_example/model/todo.dart';

final db = '''
{
  "todos": [
    {
      "uid": 1,
      "label": "todo 1",
      "completed": 0
    },
    {
      "uid": 2,
      "label": "todo 2",
      "completed": 0
    },
    {
      "uid": 3,
      "label": "todo 3",
      "completed": 1
    },
    {
      "uid": 4,
      "label": "todo 4",
      "completed": 0
    }
  ]
}''';

/// async json loader
class AsyncLoadAllCommand extends AsyncCommand<TodoModel> {
  String path;

  TodoModel _lastState;

  TodoModel get lastState => _lastState;

  AsyncLoadAllCommand(this.path);

  @override
  Future<TodoModel> execAsync(TodoModel model) async {
    model.items = await loadAll();
    _lastState = model;
    return model;
  }

  Future<BuiltList<Todo>> loadAll() async {
    //var data = await get(path);
    final rawTodos = JSON.decode(db)['todos'] as List<dynamic>;
    print('AsyncLoadAllCommand.loadAll... $rawTodos');
    return new BuiltList<Todo>(
        rawTodos.map((d) => new Todo.fromMap(d)).toList());
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
  TodoModel exec(TodoModel model) => model..items.rebuild((b) => b.add(todo));

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
    final updated = model.items.singleWhere((t) => t.uid == todo.uid);
    final updatedIndex = model.items.indexOf(updated);
    return model
      ..items.rebuild(
          (b) => b.replaceRange(updatedIndex, updatedIndex + 1, [todo]));
    //return model..items.replaceRange(updatedIndex, updatedIndex + 1, [todo]);
  }

  static CommandBuilder constructor() {
    return ([Todo todo]) => new UpdateTodoCommand(todo);
  }
}

/// remove completed tasks from archives
class ClearArchivesCommand extends Command<TodoModel> {
  @override
  TodoModel exec(TodoModel model) =>
      model..items.rebuild((b) => b.where((t) => !t.completed));

  static CommandBuilder constructor() {
    return ([t]) => new ClearArchivesCommand();
  }
}

/// complete all tasks
class CompleteAllCommand extends Command<TodoModel> {
  @override
  TodoModel exec(TodoModel model) => model
    ..items.rebuild((b) => b.map((item) {
          item.completed = true;
          return item;
        }));

  static CommandBuilder constructor() {
    return ([t]) => new CompleteAllCommand();
  }
}

/// toggle view remaining | completed
class ToggleShowArchivesCommand extends Command<TodoModel> {
  @override
  TodoModel exec(TodoModel model) =>
      model..showCompleted = !model.showCompleted;

  static CommandBuilder constructor() {
    return ([t]) => new ToggleShowArchivesCommand();
  }
}
