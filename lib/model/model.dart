import 'package:redarx/redarx.dart';
import 'package:redarx_flutter_example/model/todo.dart';

import 'package:built_collection/built_collection.dart';

class TodoModel extends AbstractModel {
  TodoModel.empty() {
    showCompleted = false;
    items = new BuiltList<Todo>([]);
  }

  BuiltList<Todo> items;

  bool showCompleted;

  List<Todo> get todos =>
      items.where((t) => showCompleted ? t.completed : !t.completed).toList();

  int get numCompleted => items.where((t)=>t.completed).length;

  int get numRemaining => items.where((t)=>!t.completed).length;

  @override
  AbstractModel initial() => new TodoModel.empty();

  @override
  String toString() {
    return '''
Model{
  showCompleted = $showCompleted,
  todos : $todos
}
''';
  }
}
