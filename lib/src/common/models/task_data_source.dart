import 'package:flutter/material.dart';
import 'package:prototype/src/common/models/task.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class TaskDataSource extends CalendarDataSource {
  TaskDataSource(List<Task> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].startDate;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].endDate ?? DateTime.now();
  }

  @override
  String getSubject(int index) {
    return appointments![index].title;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }

  @override
  Color getColor(int index) {
    return appointments![index].isCompleted ? Colors.green : Colors.red;
  }

  @override
  String? getRecurrenceRule(int index) {
    return appointments![index].toRecurrenceRule();
  }
}
