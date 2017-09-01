// GENERATED CODE - DO NOT MODIFY BY HAND

part of todomodel;

// **************************************************************************
// Generator: BuiltValueGenerator
// **************************************************************************

Serializer<TodoModel> _$todoModelSerializer = new _$TodoModelSerializer();

class _$TodoModelSerializer implements StructuredSerializer<TodoModel> {
  @override
  final Iterable<Type> types = const [TodoModel, _$TodoModel];
  @override
  final String wireName = 'TodoModel';

  @override
  Iterable serialize(Serializers serializers, TodoModel object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[
      'allTodos',
      serializers.serialize(object.allTodos,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Todo)])),
      'showCompleted',
      serializers.serialize(object.showCompleted,
          specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  TodoModel deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new TodoModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'allTodos':
          result.allTodos.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(Todo)]))
              as BuiltList<Todo>);
          break;
        case 'showCompleted':
          result.showCompleted = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

// ignore_for_file: annotate_overrides
class _$TodoModel extends TodoModel {
  @override
  final BuiltList<Todo> allTodos;
  @override
  final bool showCompleted;

  factory _$TodoModel([void updates(TodoModelBuilder b)]) =>
      (new TodoModelBuilder()..update(updates)).build();

  _$TodoModel._({this.allTodos, this.showCompleted}) : super._() {
    if (allTodos == null) throw new ArgumentError.notNull('allTodos');
    if (showCompleted == null) throw new ArgumentError.notNull('showCompleted');
  }

  @override
  TodoModel rebuild(void updates(TodoModelBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  TodoModelBuilder toBuilder() => new TodoModelBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! TodoModel) return false;
    return allTodos == other.allTodos && showCompleted == other.showCompleted;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, allTodos.hashCode), showCompleted.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TodoModel')
          ..add('allTodos', allTodos)
          ..add('showCompleted', showCompleted))
        .toString();
  }
}

class TodoModelBuilder implements Builder<TodoModel, TodoModelBuilder> {
  _$TodoModel _$v;

  ListBuilder<Todo> _allTodos;
  ListBuilder<Todo> get allTodos =>
      _$this._allTodos ??= new ListBuilder<Todo>();
  set allTodos(ListBuilder<Todo> allTodos) => _$this._allTodos = allTodos;

  bool _showCompleted;
  bool get showCompleted => _$this._showCompleted;
  set showCompleted(bool showCompleted) =>
      _$this._showCompleted = showCompleted;

  TodoModelBuilder();

  TodoModelBuilder get _$this {
    if (_$v != null) {
      _allTodos = _$v.allTodos?.toBuilder();
      _showCompleted = _$v.showCompleted;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TodoModel other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$TodoModel;
  }

  @override
  void update(void updates(TodoModelBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$TodoModel build() {
    final _$result = _$v ??
        new _$TodoModel._(
            allTodos: allTodos?.build(), showCompleted: showCompleted);
    replace(_$result);
    return _$result;
  }
}
