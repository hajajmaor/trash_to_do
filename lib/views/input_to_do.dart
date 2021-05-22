import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:trash_to_do/models/to_do.dart';

import '../main.dart';

class InputNewToDo extends StatefulWidget {
  const InputNewToDo({Key? key}) : super(key: key);

  @override
  _InputNewToDoState createState() => _InputNewToDoState();
}

class _InputNewToDoState extends State<InputNewToDo> {
  final toDoBox = Hive.box<ToDo>(kToDoBoxName);

  late final TextEditingController _controller;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onAdd(String? value) {
    if (_formKey.currentState!.validate()) {
      toDoBox
          .add(
            ToDo(description: _controller.text),
          )
          .whenComplete(
            () => _controller.clear(),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Form(
        key: _formKey,
        child: Row(
          children: [
            Expanded(
              flex: 6,
              child: TextFormField(
                onFieldSubmitted: onAdd,
                controller: _controller,
                validator: (value) => (value == null || value.length < 2)
                    ? "Must be at least 2 characters"
                    : null,
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: TextButton(
                  onPressed: () => onAdd,
                  child: const Text("Add"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
