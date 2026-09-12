import 'package:flutter/material.dart';

import 'widgets/task_card.dart';
import 'widgets/task_card_count.dart';

class NewTaskPage extends StatefulWidget {
  const new({super.key});

  @override
  State<NewTaskPage> createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Column(
        children: [
          SizedBox(
            height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 100,
                  child: TaskCardCount(title: 'New', count: 25),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(width: 5);
              },
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
                return TaskCard();
              },
            ),
          ),
        ],
      ),
    );
  }
}
