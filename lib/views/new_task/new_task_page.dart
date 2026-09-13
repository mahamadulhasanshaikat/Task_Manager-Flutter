import 'package:flutter/material.dart';
import 'package:task_manager/models/api_response.dart';
import 'package:task_manager/models/task_status_count_model.dart';
import 'package:task_manager/service/api_caller.dart';
import 'package:task_manager/utils/urls.dart';

import 'widgets/task_card.dart';
import 'widgets/task_card_count.dart';

class NewTaskPage extends StatefulWidget {
  const new({super.key});

  @override
  State<NewTaskPage> createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  List<TaskStatusCountModel> taskCountByStatus = [];

  Future<void> getAllTaskCount() async {
    final ApiResponse response = await ApiCaller.getRequest(
      url: TMUrls.taskStatusCountUrl,
    );

    List<TaskStatusCountModel> taskCount = [];

    if (response.isSuccess) {
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        taskCount.add(TaskStatusCountModel.fromJson(jsonData));
      }
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(response.responseData['data'])));
    }
    setState(() {
      taskCountByStatus = taskCount;
    });
  }

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
