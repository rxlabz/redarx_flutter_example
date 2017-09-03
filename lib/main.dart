import 'package:flutter/material.dart';
import 'package:redarx/redarx.dart';
import 'package:redarx_flutter_example/commands.dart';
import 'package:redarx_flutter_example/requests.dart';
import 'package:redarx_flutter_example/todo_screen.dart';
import 'package:redarx_flutter_example/unstart.dart';

const DATA_PATH = "https://rxlabz-dc5b2.firebaseapp.com/todos.json";

final requestMap = <RequestType, CommandBuilder>{
  RequestType.LOAD_ALL: AsyncLoadAllCommand.constructor(DATA_PATH),
  RequestType.ADD_TODO: AddTodoCommand.constructor(),
  RequestType.UPDATE_TODO: UpdateTodoCommand.constructor(),
  RequestType.CLEAR_ARCHIVES: ClearArchivesCommand.constructor(),
  RequestType.COMPLETE_ALL: CompleteAllCommand.constructor(),
  RequestType.TOGGLE_SHOW_COMPLETED: ToggleShowArchivesCommand.constructor()
};

void main() {
  runApp(new StoreProvider(requestMap: requestMap, child:new TodoApp()));
}

