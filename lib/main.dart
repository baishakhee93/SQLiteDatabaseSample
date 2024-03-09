import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:room_database_sample/tasks_bloc.dart';

import 'database.dart';
import 'home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<TasksDatabase>(
          create: (context) => TasksDatabase(),
          dispose: (context, db) => db.close(),
        ),
        ChangeNotifierProvider<TasksBloc>(
          create: (context) => TasksBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Task Manager',
        home: HomeScreen(),
      ),
    );
  }
}
