import 'package:flutter/material.dart';
import 'package:task_manager/models/api_response.dart';
import 'package:task_manager/models/task_model.dart';
import 'package:task_manager/models/task_status_count_model.dart';
import 'package:task_manager/service/api_caller.dart';
import 'package:task_manager/utils/urls.dart';

import 'widgets/add_task_bottom_sheet.dart';
import 'widgets/empty_task_view.dart';
import 'widgets/task_card.dart';
import 'widgets/task_card_count.dart';
import 'widgets/task_loading_skeleton.dart';

class NewTaskPage extends StatefulWidget {
  const NewTaskPage({super.key});

  @override
  State<NewTaskPage> createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  bool _isLoading = false;
  List<TaskStatusCountModel> _taskCountByStatus = [];
  List<TaskModel> _taskList = [];

  @override
  void initState() {
    super.initState();
    _loadAllData();
  }

  Future<void> _loadAllData() async {
    setState(() => _isLoading = true);
    await Future.wait([_fetchStatusCounts(), _fetchTasks()]);
    if (mounted) setState(() => _isLoading = false);
  }

  Future<void> _fetchStatusCounts() async {
    final ApiResponse response = await ApiCaller.getRequest(
      url: TMUrls.taskStatusCountUrl,
    );
    if (response.isSuccess && response.responseData['data'] != null) {
      _taskCountByStatus = (response.responseData['data'] as List)
          .map((data) => TaskStatusCountModel.fromJson(data))
          .toList();
    }
  }

  Future<void> _fetchTasks() async {
    final ApiResponse response = await ApiCaller.getRequest(
      url: TMUrls.taskListByStatusUrl('New'),
    );
    if (response.isSuccess && response.responseData['data'] != null) {
      _taskList = (response.responseData['data'] as List)
          .map((data) => TaskModel.fromJson(data))
          .toList();
    }
  }

  Future<void> _createNewTask(String title, String description) async {
    setState(() => _isLoading = true);

    final ApiResponse response = await ApiCaller.postRequest(
      url: TMUrls.addNewTaskUrl,
      body: {"title": title, "description": description, "status": "New"},
    );

    setState(() => _isLoading = false);

    if (mounted) {
      if (response.isSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Task added successfully!'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Color(0xFF0F172A),
          ),
        );
        _loadAllData();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to add task. Try again!'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _openAddTaskSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => AddTaskBottomSheet(onAddTask: _createNewTask),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openAddTaskSheet,
        backgroundColor: const Color(0xFF0F172A),
        icon: const Icon(Icons.add_rounded, color: Colors.white, size: 20),
        label: const Text(
          'New Task',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 13,
          ),
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _loadAllData,
          color: const Color(0xFF0F172A),
          displacement: 20,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 14, bottom: 4),
                  child: SizedBox(
                    height: 50,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      scrollDirection: Axis.horizontal,
                      itemCount: _taskCountByStatus.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 10),
                      itemBuilder: (context, index) {
                        final item = _taskCountByStatus[index];
                        return TaskCardCount(
                          title: item.sId ?? '',
                          count: item.sum?.toInt() ?? 0,
                        );
                      },
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'New Tasks',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF0F172A),
                              letterSpacing: -0.4,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE2E8F0),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${_taskList.length}',
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF475569),
                              ),
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: _loadAllData,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                          ),
                          child: const Icon(
                            Icons.refresh_rounded,
                            size: 16,
                            color: Color(0xFF64748B),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (_isLoading && _taskList.isEmpty)
                const TaskLoadingSkeleton()
              else if (_taskList.isEmpty)
                const EmptyTaskView()
              else
                SliverPadding(
                  padding: const EdgeInsets.only(bottom: 80),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return TaskCard(
                        taskModel: _taskList[index],
                        cardColor: const Color(0xFF2563EB),
                        refreshParent: _loadAllData,
                      );
                    }, childCount: _taskList.length),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
