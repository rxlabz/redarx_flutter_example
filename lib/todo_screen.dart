import 'dart:async';

import 'package:flutter/material.dart';
import 'package:redarx/redarx.dart';
import 'package:redarx_flutter_example/model/model.dart';
import 'package:redarx_flutter_example/model/todo.dart';
import 'package:redarx_flutter_example/requests.dart';
import 'package:redarx_flutter_example/values/todo.dart';

enum MenuActions { completeAll, clearAll }

class TodoScreen extends StatefulWidget {
  TodoScreen({Key key, this.title, this.dispatch, this.model$})
      : super(key: key);

  final DispatchFn dispatch;

  final Stream<TodoModel> model$;

  final String title;

  @override
  _TodoScreenState createState() => new _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  List<Todo> todos = [];

  StreamSubscription<TodoModel> modelSub$;

  TodoModel model;

  TextEditingController fieldController = new TextEditingController();

  FocusNode _focusNode;

  void _loadAll() {
    widget.dispatch(new TodoRequest.loadAll());
  }

  void _add(String label) {
    widget.dispatch(new TodoRequest.add(new Todo((b) => b..label = label)));
    fieldController.text = '';
    _focusNode.unfocus();
  }

  @override
  void initState() {
    super.initState();
    _focusNode = new FocusNode();
    modelSub$ = widget.model$.listen((TodoModel newModel) {
      setState(() {
        todos = newModel.todos;
        model = newModel;
      });
    });
    _loadAll();
  }

  @override
  void dispose() {
    modelSub$.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        actions: [_buildActionMenu()],
      ),
      bottomNavigationBar: _buildBottomNav(),
      body: _buildTodoList(),
    );
  }

  void updateTodo(Todo t) {
    widget.dispatch(new TodoRequest.update(t));
  }

  buildTodo(Todo t) => new Row(children: [
        new Checkbox(
          value: t.completed,
          onChanged: (bool value) {
            updateTodo(new Todo((b) => b
              ..label = t.label
              ..completed = value
              ..id = t.id));
          },
        ),
        new Text(t.label),
      ]);

  _buildActionMenu() => new PopupMenuButton<MenuActions>(
        onSelected: ((MenuActions a) {
          switch (a) {
            case MenuActions.completeAll:
              widget.dispatch(new TodoRequest.completeAll());
              break;
            case MenuActions.clearAll:
              widget.dispatch(new TodoRequest.clearArchives());
              break;
          }
        }),
        itemBuilder: (BuildContext context) => [
              new IconPopupMenuItem<MenuActions>(
                label: 'Complete all (${model?.numRemaining})',
                value: MenuActions.completeAll,
                icon: Icons.done_all,
              ),
              new IconPopupMenuItem<MenuActions>(
                label: 'Clear all (${model?.numCompleted})',
                value: MenuActions.clearAll,
                icon: Icons.clear_all,
              ),
            ],
      );

  _buildBottomNav() => new BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          new BottomNavigationBarItem(
              icon: new Icon(Icons.check_box_outline_blank),
              title: const Text('Remaining')),
          new BottomNavigationBarItem(
              icon: new Icon(Icons.archive), title: const Text('Archives')),
        ],
        onTap: (int tabIndex) {
          if (tabIndex == 0 && model.showCompleted)
            widget.dispatch(new TodoRequest.toggleStatusFilter());
          else if (tabIndex == 1 && (!model.showCompleted))
            widget.dispatch(new TodoRequest.toggleStatusFilter());
        },
      );

  _buildTodoList() => new Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          _buildTodoForm(),
          new Flexible(
              child: new ListView(
            children: todos.map(buildTodo).toList(),
          )),
        ],
      );

  _buildTodoForm() => new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          new Flexible(
              child: new Padding(
                  padding: new EdgeInsets.only(left: 10.0),
                  child: new TextField(
                    controller: fieldController,
                    onSubmitted: (String value) {
                      _add(value);
                    },
                  ))),
          new IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                _add(fieldController.text);
              })
        ],
      );
}

class IconPopupMenuItem<T> extends PopupMenuItem<T> {
  IconPopupMenuItem({String label, dynamic value, IconData icon})
      : super(
            value: value,
            child: new Row(
              children: <Widget>[
                new Padding(
                    padding: new EdgeInsets.only(right: 6.0),
                    child: new Icon(icon)),
                new Flexible(
                  child: new Text(label),
                  fit: FlexFit.tight,
                )
              ],
            ));
}
