import 'package:flutter/material.dart';
import 'package:prototype/src/common/controller/task_controller.dart';
import 'package:prototype/src/common/models/time_range.dart';
import 'package:prototype/src/common/types/task_view_mode.dart';
import 'package:prototype/src/common/types/time_range_tipe.dart';
import 'package:prototype/src/common/types/view_mode.dart';
import 'package:prototype/src/common/components/task_item.dart';
import 'package:prototype/src/settings/controller/view_mode_controller.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';

class TaskList extends StatefulWidget {
  final DateTime? date;
  final TimeRangeType type;
  final TaskViewMode? mode;
  const TaskList({this.mode, this.date, required this.type, super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  bool _isInRange(Task task) {
    bool inRange = false;
    TimeRange taskTimeRange = TimeRange(
      start: task.startDate,
      end: task.endDate,
    );

    switch (widget.type) {
      case TimeRangeType.morning:
        inRange = TimeRange.morning.intersects(taskTimeRange);
        break;
      case TimeRangeType.afternoon:
        inRange = TimeRange.afternoon.intersects(taskTimeRange);
        break;
      case TimeRangeType.night:
        inRange = TimeRange.night.intersects(taskTimeRange);
        inRange = inRange || TimeRange.dawn.intersects(taskTimeRange);
        break;
      case TimeRangeType.all:
      default:
        inRange = true;
    }

    return inRange;
  }

  @override
  Widget build(BuildContext context) {
    TaskViewMode view = widget.mode ?? TaskViewMode.all;

    final ViewMode mode = Provider.of<ViewModeController>(context).view;
    final TaskController controller = context.watch<TaskController>();

    final List<Task> tasks = [];

    if (view == TaskViewMode.onlyTasks || view == TaskViewMode.all) {
      tasks.addAll(controller
          .tasksFor(date: widget.date, mode: mode)
          .where((task) => _isInRange(task) && task.recurrence == null && !task.isAllDay)
          .toList());
    }

    if (view == TaskViewMode.onlyRoutines || view == TaskViewMode.all) {
      tasks.addAll(controller.routines
          .where(
            (task) =>
                _isInRange(task) &&
                task.mode == mode &&
                (task.isAllDay || task.isRecurrenceOn(widget.date)),
          )
          .toList());
    }

    Widget list = const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.checklist_rounded,
          size: 100,
          color: Colors.grey,
        ),
      ],
    );

    if (tasks.isNotEmpty) {
      list = ListView.builder(
        itemBuilder: (context, index) => TaskItem(task: tasks[index]),
        itemCount: tasks.length,
      );
    }

    return list;
  }
}
