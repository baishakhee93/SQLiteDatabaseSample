import 'package:flutter/material.dart';
import 'package:room_database_sample/task_list.dart';

import 'input_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TaskInput(),

        ],
      ),
    );
  }
}
