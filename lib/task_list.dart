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
          subtitle: Text(task.description),
          // Displaying description below the title

          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  // Show the dialog for editing the task
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      final TextEditingController _controller =
                          TextEditingController();
                      final TextEditingController _controllerDescription =
                          TextEditingController();

                      // Set the initial values of controllers to the existing task data
                      _controller.text = task.title;
                      _controllerDescription.text = task.description;

                      return AlertDialog(
                        title: Align(
                            child: Text(
                          'Edit Task',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFA40B6E)),
                        )),
                        content: Container(
                          width: double.maxFinite,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Card(
                                color: Colors.white,
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(60),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: TextField(
                                    controller: _controller,
                                    decoration: InputDecoration(
                                        labelText: 'Enter task'),
                                  ),
                                ),
                              ),
                              Card(
                                color: Colors.white,
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(60),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: TextField(
                                    controller: _controllerDescription,
                                    decoration: InputDecoration(
                                        labelText: 'Enter task description'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            child: Text('Cancel'),
                            style: ElevatedButton.styleFrom(
                            primary: Color(0xFFB4051A),
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60),
                            ),
                            ),

                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Add your logic for updating the task here
                              final title = _controller.text.trim();
                              final description =
                                  _controllerDescription.text.trim();
                              if (title.isNotEmpty) {
                                // Call the updateTask method from your bloc to update the task
                                Provider.of<TasksBloc>(context, listen: false)
                                    .updateTask(task.copyWith(
                                        title: title,
                                        description: description));
                              }
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            child: Text('Update'),
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFF03864B),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(60),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () {
                  // Show a confirmation dialog before deleting
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Delete Task"),
                        content:
                            Text("Are you sure you want to delete this task?"),
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
                              bloc.deleteTask(
                                  task.id!); // Assuming task.id is non-nullable
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
