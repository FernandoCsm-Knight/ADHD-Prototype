import 'package:flutter/material.dart';
import 'package:prototype/src/common/types/task_view_mode.dart';
import 'package:prototype/src/common/types/time_range_tipe.dart';
import 'package:prototype/src/common/components/task_list.dart';

class TaskView extends StatelessWidget {
  final DateTime? date;
  final TaskViewMode? mode;

  const TaskView({this.mode, this.date, super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const TabBar(
            tabs: [
              Tab(text: 'Todos'),
              Tab(text: 'Manhã'),
              Tab(text: 'Tarde'),
              Tab(text: 'Noite'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                TaskList(mode: mode, date: date, type: TimeRangeType.all),
                TaskList(mode: mode, date: date, type: TimeRangeType.morning),
                TaskList(mode: mode, date: date, type: TimeRangeType.afternoon),
                TaskList(mode: mode, date: date, type: TimeRangeType.night),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
