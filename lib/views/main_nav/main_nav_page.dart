import 'package:flutter/material.dart';
import 'package:task_manager/views/cancel_task/cancel_task_page.dart';
import 'package:task_manager/views/completed_task/completed_task_page.dart';
import 'package:task_manager/views/home/home_page.dart';
import 'package:task_manager/views/new_task/new_task_page.dart';
import 'package:task_manager/views/progress_task/progress_task_page.dart';

class MainNavPage extends StatefulWidget {
  const new({super.key});

  @override
  State<MainNavPage> createState() => _MainNavPageState();
}

class _MainNavPageState extends State<MainNavPage> {
  int selectedIndex = 0;
  List page = [
    NewTaskPage(),
    ProgressTaskPage(),
    CompletedTaskPage(),
    CancelTaskPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
