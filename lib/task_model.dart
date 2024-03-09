// task_model.dart
class Task {
  final int? id; // Make id optional

  final String title;
  final String description;
  final bool completed;

  Task({
    this.id, // Make id optional
    required this.title,
    required this.description,
    required this.completed,
  });

  // Convert a Task object into a Map for database operations
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'description': description,
      'completed': completed ? 1 : 0,
    };
  }

  // Create a Task object from a Map retrieved from the database
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      completed: map['completed'] == 1,
    );
  }

  // Create a copy of the task with optional modifications
  Task copyWith({
    int? id,
    String? title,
    String? description,
    bool? completed,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      completed: completed ?? this.completed,
    );
  }
}
