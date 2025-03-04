import 'package:flutter/material.dart';
import 'package:todo_list_app/data/todo_model.dart';
import 'package:todo_list_app/data/todo_database.dart';
import 'package:todo_list_app/util/dialog_box.dart';
import 'package:todo_list_app/util/todo_tile.dart';

class homepages extends StatefulWidget {
  const homepages({super.key});

  @override
  State<homepages> createState() => _homepagesState();
}

class _homepagesState extends State<homepages> {
  final TodoDatabase _database = TodoDatabase();
  final _controller = TextEditingController();
  
  List<Todo> toDoList = [];

  @override
  void initState() {
    super.initState();
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    // Initialize the database
    await _database.init();

    // Add initial data if the box is empty
    await _database.addInitialData();

    // Load todos
    _loadTodos();
  }

  void _loadTodos() {
    setState(() {
      toDoList = _database.getAllTodos();
    });
  }

  Future<void> savedNewtask() async {
    if (_controller.text.isNotEmpty) {
      final newTodo = Todo(
        taskName: _controller.text, 
        isCompleted: false
      );
      
      await _database.addTodo(newTodo);
      
      setState(() {
        toDoList = _database.getAllTodos();
        _controller.clear();
      });
      Navigator.of(context).pop();
    }
  }

  Future<void> checkBoxChanged(int index) async {
    Todo todo = toDoList[index];
    todo.isCompleted = !todo.isCompleted;
    
    await _database.updateTodo(index, todo);
    
    setState(() {
      toDoList = _database.getAllTodos();
    });
  }
  
  Future<void> deletetask(int index) async {
    await _database.deleteTodo(index);
    
    setState(() {
      toDoList = _database.getAllTodos();
    });
  }

  void createnewtask() {
    showDialog(
      context: context, 
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: savedNewtask,
          oncancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: Text('To Do'),
        backgroundColor: Colors.yellow,
        elevation: 100,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createnewtask,
        child: Icon(Icons.add),
        backgroundColor: Colors.yellow,
      ),
      body: ListView.builder(
        itemCount: toDoList.length,
        itemBuilder: (context, index) {
          return TodoTile(
            taskname: toDoList[index].taskName,
            taskcompleted: toDoList[index].isCompleted,
            onChanged: (_) => checkBoxChanged(index),
            deletefunction: (context) => deletetask(index),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}