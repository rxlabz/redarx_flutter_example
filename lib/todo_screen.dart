import 'dart:async';

import 'package:flutter/material.dart';
import 'package:redarx/redarx.dart';
import 'package:redarx_flutter_example/model/model.dart';
import 'package:redarx_flutter_example/model/todo.dart';
import 'package:redarx_flutter_example/requests.dart';

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
    widget.dispatch(new TodoRequest.add(new Todo(label)));
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
    final bottomNav = new BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        new BottomNavigationBarItem(
            icon: new Icon(Icons.check_box_outline_blank),
            title: const Text('Remaining')),
        new BottomNavigationBarItem(
            icon: new Icon(Icons.archive), title: const Text('Archives')),
      ],onTap: (int tabIndex){
        if( tabIndex == 0 && model.showCompleted)
          widget.dispatch(new TodoRequest.toggleStatusFilter());
        else if( tabIndex == 1 && ( ! model.showCompleted))
          widget.dispatch(new TodoRequest.toggleStatusFilter());
    },
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        actions: [
          new Row(children: [
            new IconButton(
                icon: const Icon(Icons.done_all),
                tooltip: "Complete all",
                onPressed: () =>
                    widget.dispatch(new TodoRequest.completeAll())),
            new Text("(${model?.numRemaining})"),
            new IconButton(
                icon: const Icon(Icons.clear_all),
                tooltip: "Clear all",
                onPressed: () =>
                    widget.dispatch(new TodoRequest.clearArchives())),
            new Text("(${model?.numCompleted})"),
          ]),
        ],
      ),
      bottomNavigationBar: bottomNav,
      body: new Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              new Flexible(
                  child: new TextField(
                controller: fieldController,
                onSubmitted: (String value) {
                  _add(value);
                },
              )),
              new IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    _add(fieldController.text);
                  })
            ],
          ),
          new Flexible(
              child: new ListView(
            children: todos.map(buildTodo).toList(),
          )),
        ],
      ),
    );
  }

  void updateTodo(Todo t) {
    widget.dispatch(new TodoRequest.update(t));
  }

  buildTodo(Todo t) => new Row(children: [
        new Checkbox(
          value: t.completed,
          onChanged: (bool value) {
            updateTodo(new Todo(t.label, value, t.uid));
          },
        ),
        new Text(t.label),
      ]);
}
