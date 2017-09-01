library todo;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'todo.g.dart';

abstract class Todo implements Built<Todo, TodoBuilder> {
  static Serializer<Todo> get serializer => _$todoSerializer;

  String get label;

  @nullable
  String get id;

  bool get completed;

  factory Todo([updates(TodoBuilder b)]) = _$Todo;

  factory Todo.fromMap(Map<String, dynamic> data) => new Todo(
        (b) => b
          ..label = data['label']
          ..completed = data['completed'] == 1
          ..id = data['uid'].toString(),
      );
  factory Todo.add(String label) => new Todo(
        (b) => b
          ..label = label
          ..completed = false
      );

  Todo._();
}
