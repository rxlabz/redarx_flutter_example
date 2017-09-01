# redarx_flutter_example

Simple flutter todo app using [Redarx](https://github.com/rxlabz/redarx) for state management

## Usage

```dart
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
``` 

the dispatch method and model stream are injected in each screen

```dart
new TodoScreen(title: 'Todo', dispatch: dispatch, model$: model$)
```

Requests are simply dispatched via the dispatch method 

```dart
void _loadAll() {
  widget.dispatch(new TodoRequest.loadAll());
}
```

## Todo 

- [x] popup menu
- [ ] Built enum for Request ?
- [ ] Built_value : value type , Models?
- [ ] firebase database
- [ ] firebase auth
- [ ] multiple store : AppStore(auth) + TodoStore => multiple request
- [ ] Flutter Notif Vs InheritedWidget
- [ ] widgets tests