import 'package:flutter/material.dart';

class TimeRange {
  late final DateTime _start;
  late final DateTime _end;

  TimeRange({required DateTime start, required DateTime end}) {
    final DateTime s = DateTime(0, 1, 1, start.hour, start.minute);
    final DateTime e = DateTime(0, 1, 1, end.hour, end.minute);

    if (s.isAfter(e)) {
      throw ArgumentError('Start time must be before end time');
    }

    _start = s;
    _end = e;
  }

  DateTime get start => _start;
  DateTime get end => _end;

  static DateTime _timeOfDayToDateTime(TimeOfDay time) {
    return DateTime(0, 1, 1, time.hour, time.minute);
  }

  static TimeRange get all => TimeRange(
        start: _timeOfDayToDateTime(const TimeOfDay(hour: 0, minute: 0)),
        end: _timeOfDayToDateTime(const TimeOfDay(hour: 23, minute: 59)),
      );

  static TimeRange get morning => TimeRange(
        start: _timeOfDayToDateTime(const TimeOfDay(hour: 6, minute: 0)),
        end: _timeOfDayToDateTime(const TimeOfDay(hour: 11, minute: 59)),
      );

  static TimeRange get afternoon => TimeRange(
        start: _timeOfDayToDateTime(const TimeOfDay(hour: 12, minute: 0)),
        end: _timeOfDayToDateTime(const TimeOfDay(hour: 17, minute: 59)),
      );

  static TimeRange get night => TimeRange(
        start: _timeOfDayToDateTime(const TimeOfDay(hour: 18, minute: 0)),
        end: _timeOfDayToDateTime(const TimeOfDay(hour: 23, minute: 59)),
      );

  static TimeRange get dawn => TimeRange(
        start: _timeOfDayToDateTime(const TimeOfDay(hour: 0, minute: 0)),
        end: _timeOfDayToDateTime(const TimeOfDay(hour: 5, minute: 59)),
      );

  bool contains(DateTime time) {
    final DateTime comparisonTime = DateTime(0, 1, 1, time.hour, time.minute);
    return comparisonTime.isAfter(_start) && comparisonTime.isBefore(_end) || 
           comparisonTime.isAtSameMomentAs(_start) || 
           comparisonTime.isAtSameMomentAs(_end);
  }

  bool intersects(TimeRange timeRange) {
    return contains(timeRange.start) || contains(timeRange.end);
  }

  @override
  String toString() {
    return '${_start.toLocal().hour}:${_start.toLocal().minute} - ${_end.toLocal().hour}:${_end.toLocal().minute}';
  }
}
