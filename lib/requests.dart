import 'package:redarx/redarx.dart';
import 'package:redarx_flutter_example/model/todo.dart';


enum RequestType {
  ADD_TODO,
  CANCEL_TODO,
  UPDATE_TODO,
  CLEAR_ARCHIVES,
  TOGGLE_SHOW_COMPLETED,
  COMPLETE_ALL,
  LOAD_ALL
}

class TodoRequest<T extends Todo> extends Request<RequestType, T> {
  TodoRequest.loadAll() : super(RequestType.LOAD_ALL);
  TodoRequest.clearArchives() : super(RequestType.CLEAR_ARCHIVES);
  TodoRequest.completeAll() : super(RequestType.COMPLETE_ALL);
  TodoRequest.toggleStatusFilter() : super(RequestType.TOGGLE_SHOW_COMPLETED);
  TodoRequest.add(T todo) : super(RequestType.ADD_TODO, withData: todo);
  TodoRequest.cancel(T todo) : super(RequestType.CANCEL_TODO, withData: todo);
  TodoRequest.update(T todo) : super(RequestType.UPDATE_TODO, withData: todo);
}