import 'dart:convert';

import 'package:hive/hive.dart';

part 'to_do.g.dart';

@HiveType(typeId: 1)
class ToDo extends HiveObject {
  @HiveField(0)
  final String description;
  @HiveField(1)
  bool done;
  ToDo({
    required this.description,
    this.done = false,
  });

  ToDo copyWith({
    String? description,
    bool? done,
  }) {
    return ToDo(
      description: description ?? this.description,
      done: done ?? this.done,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'done': done,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'ToDo(description: $description, done: $done)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ToDo &&
        other.description == description &&
        other.done == done;
  }

  @override
  int get hashCode => description.hashCode ^ done.hashCode;
}
