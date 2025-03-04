import 'package:hive/hive.dart';
import 'package:todo_list_app/data/todo_model.dart';

class TodoDatabase {
  static final TodoDatabase _instance = TodoDatabase._internal();
  factory TodoDatabase() => _instance;
  TodoDatabase._internal();

  late Box<Todo> _todoBox;

  Future<void> init() async {
    _todoBox = await Hive.openBox<Todo>('todobox');
  }

  List<Todo> getAllTodos() {
    return _todoBox.values.toList();
  }

  Future<void> addTodo(Todo todo) async {
    await _todoBox.add(todo);
  }

  Future<void> updateTodo(int index, Todo todo) async {
    await _todoBox.putAt(index, todo);
  }

  Future<void> deleteTodo(int index) async {
    await _todoBox.deleteAt(index);
  }

  // New method to check if the box is empty
  bool get isEmpty => _todoBox.isEmpty;

  // Method to add initial data if the box is empty
  Future<void> addInitialData() async {
    if (isEmpty) {
      await addTodo(Todo(taskName: "Welcome to Todo App", isCompleted: false));
    }
  }
}