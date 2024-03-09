import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:room_database_sample/task_model.dart';
import 'package:room_database_sample/tasks_bloc.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<TasksBloc>(context);

    return ListView.builder(
      itemCount: bloc.tasks.length,
      itemBuilder: (context, index) {
        final task = bloc.tasks[index];
        return ListTile(
          title: Text(task.title),
          subtitle: Text(task.description), // Displaying description below the title

          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  // Navigate to the edit screen, pass the task to edit
                  // You can use Navigator.push or showModalBottomSheet for this
                  // Example using Navigator.push:
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditTaskScreen(task: task),
                    ),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  // Show a confirmation dialog before deleting
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Delete Task"),
                        content: Text("Are you sure you want to delete this task?"),
                        actions: [
                          TextButton(
                            child: Text("Cancel"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text("Delete"),
                            onPressed: () {
                              bloc.deleteTask(task.id!); // Assuming task.id is non-nullable
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              Checkbox(
                value: task.completed,
                onChanged: (value) {
                  final updatedTask = task.copyWith(completed: value!);
                  bloc.updateTask(updatedTask);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

// Example EditTaskScreen widget (you can customize this)
class EditTaskScreen extends StatelessWidget {
  final Task task;

  const EditTaskScreen({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Implement your task editing UI here
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Task"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Edit Task: ${task.title}"),
            // Add form fields and save button for editing task details
          ],
        ),
      ),
    );
  }
}
