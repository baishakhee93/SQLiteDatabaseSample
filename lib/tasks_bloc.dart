// tasks_bloc.dart
import 'package:flutter/material.dart';
import 'package:room_database_sample/database.dart';
import 'package:room_database_sample/task_model.dart';

class TasksBloc extends ChangeNotifier {
  final TasksDatabase _database = TasksDatabase.instance;
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  Future<void> loadTasks() async {
    _tasks = await _database.getAllTasks();
    notifyListeners(); // Notify listeners once after updating the entire list
  }

  Future<void> addTask(String title, String description) async {
    await _database.insertTask(Task(title: title, description: description, completed: false));
    await loadTasks(); // Reload all tasks from the database
  }

  Future<void> updateTask(Task task) async {
    await _database.updateTask(task);
    await loadTasks();
  }

  Future<void> deleteTask(int taskId) async {
    await _database.deleteTask(taskId);
    await loadTasks();
  }
}
