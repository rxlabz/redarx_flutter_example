library todomodel;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:redarx/redarx.dart';
import 'package:redarx_flutter_example/values/todo.dart';

part 'todomodel.g.dart';

abstract class TodoModel extends AbstractModel
    implements Built<TodoModel, TodoModelBuilder> {
  static Serializer<TodoModel> get serializer => _$todoModelSerializer;

  TodoModel._();

  factory TodoModel.empty() => new TodoModel((b) => b
    ..allTodos = new BuiltList<Todo>().toBuilder()
    ..showCompleted = false);

  factory TodoModel([updates(TodoModelBuilder b)]) = _$TodoModel;

  BuiltList<Todo> get allTodos;

  bool get showCompleted;

  List<Todo> get todos => allTodos
      .where((t) => showCompleted ? t.completed : !t.completed)
      .toList();

  int get numCompleted => allTodos.where((t) => t.completed).length;

  int get numRemaining => allTodos.where((t) => !t.completed).length;

  @override
  AbstractModel initial() => new TodoModel.empty();
}
