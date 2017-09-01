// GENERATED CODE - DO NOT MODIFY BY HAND

part of todo;

// **************************************************************************
// Generator: BuiltValueGenerator
// **************************************************************************

Serializer<Todo> _$todoSerializer = new _$TodoSerializer();

class _$TodoSerializer implements StructuredSerializer<Todo> {
  @override
  final Iterable<Type> types = const [Todo, _$Todo];
  @override
  final String wireName = 'Todo';

  @override
  Iterable serialize(Serializers serializers, Todo object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'label',
      serializers.serialize(object.label,
          specifiedType: const FullType(String)),
      'completed',
      serializers.serialize(object.completed,
          specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  Todo deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new TodoBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'label':
          result.label = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'completed':
          result.completed = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

// ignore_for_file: annotate_overrides
class _$Todo extends Todo {
  @override
  final String id;
  @override
  final String label;
  @override
  final bool completed;

  factory _$Todo([void updates(TodoBuilder b)]) =>
      (new TodoBuilder()..update(updates)).build();

  _$Todo._({this.id, this.label, this.completed}) : super._() {
    if (id == null) throw new ArgumentError.notNull('id');
    if (label == null) throw new ArgumentError.notNull('label');
    if (completed == null) throw new ArgumentError.notNull('completed');
  }

  @override
  Todo rebuild(void updates(TodoBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  TodoBuilder toBuilder() => new TodoBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! Todo) return false;
    return id == other.id &&
        label == other.label &&
        completed == other.completed;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, id.hashCode), label.hashCode), completed.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Todo')
          ..add('id', id)
          ..add('label', label)
          ..add('completed', completed))
        .toString();
  }
}

class TodoBuilder implements Builder<Todo, TodoBuilder> {
  _$Todo _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  String _label;
  String get label => _$this._label;
  set label(String label) => _$this._label = label;

  bool _completed;
  bool get completed => _$this._completed;
  set completed(bool completed) => _$this._completed = completed;

  TodoBuilder();

  TodoBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _label = _$v.label;
      _completed = _$v.completed;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Todo other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$Todo;
  }

  @override
  void update(void updates(TodoBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Todo build() {
    final _$result =
        _$v ?? new _$Todo._(id: id, label: label, completed: completed);
    replace(_$result);
    return _$result;
  }
}
