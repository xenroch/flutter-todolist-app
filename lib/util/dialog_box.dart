import 'package:flutter/material.dart';
import 'package:todo_list_app/util/my_button.dart';

// ignore: must_be_immutable
class DialogBox extends StatelessWidget {
  VoidCallback onSave;
  VoidCallback oncancel;
  final controller;

   DialogBox({
    super.key,
     required this.controller,
     required this.onSave,
     required this.oncancel,
     });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[300],
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          // input
          TextField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: " tambahkan tugas baru",
              ),
          ),
          //button cancel-save
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              //save button
              MyButton(text: "save", onPressed: onSave),

              const SizedBox(width: 4,),
              //cancel button
              MyButton(text: "cancel", onPressed: oncancel)
            ],
          )
        ],),
      ),
    );
  }
}