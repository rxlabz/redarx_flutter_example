import 'dart:async';

import 'package:flutter/material.dart';
import 'package:redarx/redarx.dart';
import 'package:redarx_flutter_example/requests.dart';
import 'package:redarx_flutter_example/todo_screen.dart';
import 'package:redarx_flutter_example/values/todomodel.dart';

class UnstartContainer extends InheritedWidget {
  final _store =
      new Store<Command<TodoModel>, TodoModel>(() => new TodoModel.empty());
  final _dispatcher = new Dispatcher();

  Stream<TodoModel> get model$ => _store.state$;

  DispatchFn get dispatch => _dispatcher.dispatch;

  UnstartContainer({Key key, Widget child, Map<RequestType, CommandBuilder> requestMap})
      : super(key: key, child: new TodoApp()) {
    new Commander<Command<TodoModel>, TodoModel>(
      new CommanderConfig<RequestType, TodoModel>(requestMap),
      _store,
      _dispatcher.request$,
    );
  }

  static UnstartContainer of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(UnstartContainer);

  @override
  bool updateShouldNotify(UnstartContainer oldWidget) => false; // the requestsMap is only defined
      /*oldWidget._requestMap != _requestMap;*/
}
