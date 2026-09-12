import 'package:flutter/material.dart';

import '../new_task/widgets/task_card.dart';

class CancelTaskPage extends StatefulWidget {
  const new({super.key});

  @override
  State<CancelTaskPage> createState() => _CancelTaskPageState();
}

class _CancelTaskPageState extends State<CancelTaskPage> {
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
