import 'package:flutter/material.dart';
import 'package:task_manager/utils/urls.dart';

import '../../models/api_response.dart';
import '../../models/task_model.dart';
import '../../service/api_caller.dart';
import '../new_task/widgets/task_card.dart';

class CancelTaskPage extends StatefulWidget {
  const CancelTaskPage({super.key});

  @override
  State<CancelTaskPage> createState() => _CancelTaskPageState();
}

class _CancelTaskPageState extends State<CancelTaskPage> {
  bool _isLoading = false;
  List<TaskModel> _taskList = [];

  // Cancelled টাস্কের অ্যাকসেন্ট কালার (Soft Red/Crimson)
  final Color _cancelColor = const Color(0xFFEF4444);

  @override
  void initState() {
    super.initState();
    _fetchCancelledTasks();
  }

  Future<void> _fetchCancelledTasks() async {
    setState(() => _isLoading = true);
    // ব্যাকএন্ড স্ট্যাটাস নাম অনুযায়ী 'Cancelled' বা 'Cancel' হ্যান্ডেল করা
    final ApiResponse response = await ApiCaller.getRequest(
      url: TMUrls.taskListByStatusUrl('Cancelled'),
    );

    if (mounted) {
      if (response.isSuccess && response.responseData['data'] != null) {
        final List<TaskModel> tList = [];
        for (Map<String, dynamic> jsonData in response.responseData['data']) {
          tList.add(TaskModel.fromJson(jsonData));
        }
        setState(() {
          _taskList = tList;
          _isLoading = false;
        });
      } else {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              response.responseData['data'] ?? 'Failed to load cancelled tasks',
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  Widget _buildLoadingSkeleton() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFF1F5F9)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 150,
                  height: 16,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  height: 11,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  width: 210,
                  height: 11,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 75,
                      height: 20,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    Container(
                      width: 80,
                      height: 14,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          childCount: 4,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _fetchCancelledTasks,
          color: _cancelColor,
          displacement: 20,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              // হেডার সেকশন
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 18, 16, 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Cancelled',
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
                              color: _cancelColor.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${_taskList.length}',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: _cancelColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: _fetchCancelledTasks,
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

              // কনটেন্ট স্টেট
              if (_isLoading && _taskList.isEmpty)
                _buildLoadingSkeleton()
              else if (_taskList.isEmpty)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                          ),
                          child: Icon(
                            Icons.cancel_outlined,
                            size: 34,
                            color: _cancelColor.withOpacity(0.7),
                          ),
                        ),
                        const SizedBox(height: 14),
                        const Text(
                          'No cancelled tasks',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF334155),
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Dropped or rejected tasks will appear here.',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF94A3B8),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.only(bottom: 24),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return TaskCard(
                        taskModel: _taskList[index],
                        cardColor: _cancelColor,
                        refreshParent: _fetchCancelledTasks,
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
