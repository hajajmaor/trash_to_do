import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:trash_to_do/main.dart';
import 'package:trash_to_do/models/to_do.dart';
import 'package:trash_to_do/views/to_do_view.dart';

import 'input_to_do.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final toDoBox = Hive.box<ToDo>(kToDoBoxName);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Trash To Do",
        ),
      ),
      body: ValueListenableBuilder<Box<ToDo>>(
        valueListenable: toDoBox.listenable(),
        builder: (_, box, child) {
          final values = box.values.toList();
          return Column(
            children: [
              child!,
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 250,
                    childAspectRatio: 2.5,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 5,
                  ),
                  itemCount: values.length,
                  itemBuilder: (BuildContext _, int index) => Tooltip(
                    message: "Swipe me to delete",
                    child: Center(
                      child: ToDoView(
                        task: values[index],
                        key: ValueKey(values[index].key),
                        index: index,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        child: const InputNewToDo(),
      ),
    );
  }
}
