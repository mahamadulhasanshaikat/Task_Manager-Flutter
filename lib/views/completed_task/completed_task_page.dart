import 'package:flutter/material.dart';

import '../new_task/widgets/task_card.dart';

class CompletedTaskPage extends StatefulWidget {
  const new({super.key});

  @override
  State<CompletedTaskPage> createState() => _CompletedTaskPageState();
}

class _CompletedTaskPageState extends State<CompletedTaskPage> {
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