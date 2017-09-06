# redarx_flutter_example

Simple flutter todo app using [Redarx](https://github.com/rxlabz/redarx) for state management.

Uses [built_value](https://github.com/google/built_value.dart) & [built_collection](https://github.com/google/built_collection.dart) for immutable value types & models. 

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
  runApp(new StoreProvider(requestMap: requestMap, child:new TodoApp()));
}
``` 

The dispatch method and the model are available from the StoreProvider ( an InheritedWidget )

```dart
class _TodoScreenState extends State<TodoScreen> {
// ...
  
DispatchFn get dispatch => StoreProvider.of(context).dispatch;

// ...

@override
void didChangeDependencies() {
  super.didChangeDependencies();

  modelSub$ =
    StoreProvider.of(context).model$.listen((TodoModel newModel) {
      setState(() {
      model = newModel;
    });
  });
  _loadAll();
}

// ...

widget _buildActionMenu() => new PopupMenuButton<MenuActions>(
        onSelected: ((MenuActions a) {
          switch (a) {
            case MenuActions.completeAll:
              dispatch(new TodoRequest.completeAll());
              break;
            case MenuActions.clearAll:
              dispatch(new TodoRequest.clearArchives());
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

}
```



### Unstart Inherited widget

aka Model View Update

- avoid direct injection : children can access to model$ ( todo & showCompleted property ) and dispatch method 

## Todo 

- [x] popup menu
- [x] Built_value : immutable value type & Models
- [x] InheritedWidget
- [ ] Flutter Notif : could avoid view to know anything about StateManagement 
- [ ] firebase database
- [ ] Built enum for Request ?
- [ ] firebase auth
- [ ] multiple store : AppStore(auth) + TodoStore => multiple request
- [ ] widgets tests
