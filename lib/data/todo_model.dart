import 'package:hive/hive.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 0)
class Todo extends HiveObject {
  @HiveField(0)
  String taskName;

  @HiveField(1)
  bool isCompleted;

  Todo({
    required this.taskName,
    required this.isCompleted,
  });
}