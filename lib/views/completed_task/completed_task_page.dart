import 'package:flutter/material.dart';
import 'package:task_manager/utils/urls.dart';

import '../../models/api_response.dart';
import '../../models/task_model.dart';
import '../../service/api_caller.dart';
import '../new_task/widgets/task_card.dart';

class CompletedTaskPage extends StatefulWidget {
  const new({super.key});

  @override
  State<CompletedTaskPage> createState() => _CompletedTaskPageState();
}
//CancelTaskPage
class _CompletedTaskPageState extends State<CompletedTaskPage> {
  @override
  void initState() {
    super.initState();
    getTask('Completed');
  }

  List<TaskModel> taskList = [];
  Future<void> getTask(String status) async {
    final ApiResponse response = await ApiCaller.getRequest(
      url: TMUrls.taskListByStatusUrl(status),
    );

    List<TaskModel> tList = [];

    if (response.isSuccess) {
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        tList.add(TaskModel.fromJson(jsonData));
      }
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(response.responseData['data'])));
    }
    setState(() {
      taskList = tList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: taskList.length,
        itemBuilder: (context, index) {
          return TaskCard(
            taskModel: taskList[index],
            cardColor: Colors.blue,
            refreshParent: () {},
          );
        },
      ),
    );
  }
}
