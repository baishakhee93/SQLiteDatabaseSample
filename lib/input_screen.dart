import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:room_database_sample/task_list.dart';
import 'package:room_database_sample/tasks_bloc.dart';

class TaskInput extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controllerDescription = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
        Card(
                elevation: 100,
                margin: EdgeInsets.only(left: 20, right: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Card(
                        color: Colors.white,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            controller: _controller,
                            decoration:
                                InputDecoration(labelText: 'Enter task'),
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
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            controller: _controllerDescription,
                            decoration: InputDecoration(
                                labelText: 'Enter task description'),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          final title = _controller.text.trim();
                          final description =
                              _controllerDescription.text.trim();
                          if (title.isNotEmpty) {
                            Provider.of<TasksBloc>(context, listen: false)
                                .addTask(title, description);
                            _controller.clear();
                            _controllerDescription.clear();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue.shade700,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Add',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

          ],
        ),
      ),
    );
  }
}
