import 'package:flutter/material.dart';

import '../new_task/widgets/task_card.dart';

class ProgressTaskPage extends StatefulWidget {
  const new({super.key});

  @override
  State<ProgressTaskPage> createState() => _ProgressTaskPageState();
}

class _ProgressTaskPageState extends State<ProgressTaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return TaskCard();
        },
      ),
    );
 
 
  }
}
