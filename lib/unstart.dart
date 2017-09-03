import 'dart:async';

import 'package:flutter/material.dart';
import 'package:redarx/redarx.dart';
import 'package:redarx_flutter_example/requests.dart';
import 'package:redarx_flutter_example/values/todomodel.dart';

class StoreProvider extends InheritedWidget {
  final _store =
      new Store<Command<TodoModel>, TodoModel>(() => new TodoModel.empty());
  final _dispatcher = new Dispatcher();

  Stream<TodoModel> get model$ => _store.state$;

  DispatchFn get dispatch => _dispatcher.dispatch;

  StoreProvider(
      {Key key, Widget child, Map<RequestType, CommandBuilder> requestMap})
      : super(key: key, child: child) {
    new Commander<Command<TodoModel>, TodoModel>(
      new CommanderConfig<RequestType, TodoModel>(requestMap),
      _store,
      _dispatcher.request$,
    );
  }

  static StoreProvider of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(StoreProvider);

  @override
  bool updateShouldNotify(StoreProvider oldWidget) => false;
  // the requestsMap is only defined once
}

/// experimental: use notif instead of "injected" dispatch ?
/// new UnstartNotification<String>.add('test').dispatch(context);
///
/// autre piste : fmk light flutter only => notif => mapToCommand => exec return model
class UnstartNotification<T> extends Notification {
  RequestType type;
  T payload;

  UnstartNotification(RequestType type, this.payload);

  factory UnstartNotification.add(T value) =>
      new UnstartNotification(RequestType.ADD_TODO, value);
}
