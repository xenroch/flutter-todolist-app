import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart'; // Make sure to import this

// ignore: must_be_immutable
class TodoTile extends StatelessWidget {
  final String taskname;
  final bool taskcompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deletefunction;

  TodoTile({
    super.key,
    required this.taskname,
    required this.taskcompleted,
    required this.onChanged,
    required this.deletefunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25, top: 25),
      child: Slidable(
        // Add the key actions here
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deletefunction,
              icon: Icons.delete,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(12),
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.circular(12)
          ),
          child: Row(
            children: [
              // Checkbox
              Checkbox(
                value: taskcompleted,
                onChanged: onChanged,
                activeColor: Colors.black,
              ),
              // Task name
              Text(
                taskname,
                style: TextStyle(
                  decoration: taskcompleted 
                    ? TextDecoration.lineThrough 
                    : TextDecoration.none
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}