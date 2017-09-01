import 'dart:async';

import 'package:flutter/material.dart';
import 'package:redarx/redarx.dart';
import 'package:redarx_flutter_example/commands.dart';
import 'package:redarx_flutter_example/model/model.dart';
import 'package:redarx_flutter_example/requests.dart';
import 'package:redarx_flutter_example/todo_screen.dart';

const DATA_PATH = "todos.json";

final requestMap = <RequestType, CommandBuilder>{
  RequestType.LOAD_ALL: AsyncLoadAllCommand.constructor(DATA_PATH),
  RequestType.ADD_TODO: AddTodoCommand.constructor(),
  RequestType.UPDATE_TODO: UpdateTodoCommand.constructor(),
  RequestType.CLEAR_ARCHIVES: ClearArchivesCommand.constructor(),
  RequestType.COMPLETE_ALL: CompleteAllCommand.constructor(),
  RequestType.TOGGLE_SHOW_COMPLETED: ToggleShowArchivesCommand.constructor()
};

void main() {
  final cfg = new CommanderConfig<RequestType, TodoModel>(requestMap);
  final store =
      new Store<Command<TodoModel>, TodoModel>(() => new TodoModel.empty());
  final dispatcher = new Dispatcher();

  new Commander<Command<TodoModel>, TodoModel>(
      cfg, store, dispatcher.request$);

  runApp(new TodoApp(dispatcher.dispatch, store.state$));
}

class TodoApp extends StatelessWidget {
  final DispatchFn dispatch;
  final Stream<TodoModel> model$;
  TodoApp(this.dispatch, this.model$);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Redarx Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new TodoScreen(title: 'Todo', dispatch: dispatch, model$: model$),
    );
  }
}
