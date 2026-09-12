import 'package:flutter/material.dart';
import 'package:task_manager/views/cancel_task/cancel_task_page.dart';
import 'package:task_manager/views/new_task/new_task_page.dart';
import 'package:task_manager/views/progress_task/progress_task_page.dart';

import '../completed_task/completed_task_page.dart';

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(
                'https://wallpapers.com/images/featured/cool-profile-pictures-87h46gcobjl5e4xu.jpg',
              ),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mahamadul Hasan Shaikat',
                  style: Theme.of(context).textTheme.titleSmall!
                      .copyWith(color: Colors.white),
                ),
                Text(
                  'md.shaikat.dev@gmail.com',
                  style: Theme.of(context).textTheme.titleSmall!
                      .copyWith(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
      body: page[selectedIndex],

      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (int index) {
          selectedIndex = index;
          setState(() {});
        },
        destinations: [
          NavigationDestination(icon: Icon(Icons.task), label: 'New'),
          NavigationDestination(icon: Icon(Icons.refresh), label: 'Progress'),
          NavigationDestination(
            icon: Icon(Icons.task_alt_outlined),
            label: 'Completed',
          ),
          NavigationDestination(
            icon: Icon(Icons.cancel_outlined),
            label: 'Cancel',
          ),
        ],
      ),
    );
  }
}
