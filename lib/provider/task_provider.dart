import 'package:flutter/material.dart';

class TaskProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _tasks = [];

  List<Map<String, dynamic>> get tasks => _tasks;

  void addTask(String title, String description) {
    _tasks.add({
      "title": title,
      "description": description,
      "completed": false,
    });
    notifyListeners();
  }

  void editTask(int index, String title, String description) {
    _tasks[index] = {
      "title": title,
      "description": description,
      "completed": _tasks[index]["completed"],
    };
    notifyListeners();
  }

  void deleteTask(int index) {
    _tasks.removeAt(index);
    notifyListeners();
  }

  void toggleTaskCompletion(int index) {
    _tasks[index]["completed"] = !_tasks[index]["completed"];
    notifyListeners();
  }
}
