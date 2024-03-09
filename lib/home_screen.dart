import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:room_database_sample/task_list.dart';
import 'package:room_database_sample/tasks_bloc.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller =
  TextEditingController();
  final TextEditingController _controllerDescription =
  TextEditingController();


  // Create FocusNode instances for each TextField in the dialog
  final FocusNode _titleFocus = FocusNode();
  final FocusNode _descriptionFocus = FocusNode();

  @override
  void dispose() {
    // Dispose of the FocusNode instances when the widget is disposed
    _titleFocus.dispose();
    _descriptionFocus.dispose();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    // Load tasks when the widget is first created
    Provider.of<TasksBloc>(context, listen: false).loadTasks();
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 3.6,
                  decoration: BoxDecoration(
                    color: Color(0xFFA40B6E),
                    borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(70)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 40),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                backgroundColor: Colors.grey,
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Welcome',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                  Text(
                                    'Your Name',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Icon(
                                Icons.settings,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          SizedBox(height: 10),
                          Text(
                            'Task List',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 5.6,
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.5,
                  child: Card(
                    elevation: 100,
                    margin: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TaskList(),
                  )),
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: FloatingActionButton(
                backgroundColor: Color(0xFFA40B6E), // Set the color to red or any color you prefer

                onPressed: () {
                  // Show the dialog for adding a new task
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                           return AlertDialog(
                        title: Align(child: Text('Add Task',style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xFFA40B6E)),)),
                        content: Container(
                          height: MediaQuery.of(context).size.height / 5,
                          child: Column(
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
                                    focusNode: _titleFocus,
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: TextField(
                                    controller: _controllerDescription,
                                    focusNode: _descriptionFocus,
                                    decoration: InputDecoration(
                                        labelText: 'Enter task description'),
                                  ),
                                ),
                              ),
                              // Add other widgets as needed
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
                              primary: Color(0xFFC9092C),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(60),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Add your logic for adding the task here
                              final title = _controller.text.trim();
                              final description =
                              _controllerDescription.text.trim();
                              if (title.isNotEmpty) {
                                Provider.of<TasksBloc>(context, listen: false)
                                    .addTask(title, description);
                              }
                              Navigator.of(context).pop(); // Close the dialog
                              _controller.clear();
                              _controllerDescription.clear();
                            },
                            child: Text('Add'),
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
                child: Icon(Icons.add,),
              ),
            ),


          ],
        ),
      ),
    );

  }
}

