import 'package:flutter/material.dart';
import 'package:trash_to_do/models/to_do.dart';

class ToDoView extends StatelessWidget {
  final ToDo task;

  final int index;
  const ToDoView({
    required this.task,
    required Key key,
    required this.index,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (direction) async {
        // Hive.box<ToDo>(kToDoBoxName).deleteAt(index);
        await task.delete();
      },
      key: key!,
      direction: DismissDirection.vertical,
      child: CheckboxListTile(
        title: Text(
          task.description,
          style: task.done
              ? const TextStyle(
                  decoration: TextDecoration.lineThrough,
                  decorationThickness: 1.5,
                )
              : null,
        ),
        onChanged: (bool? value) async {
          task.done = value ?? false;
          await task.save();
        },
        value: task.done,
      ),
    );
  }
}
