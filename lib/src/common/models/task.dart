import 'package:flutter/material.dart';
import 'package:prototype/src/common/types/view_mode.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Task {
  final String uuid;
  final ViewMode mode;
  int? _repeat;
  String _title;
  String? _description;
  String? _owner;
  bool isCompleted;
  DateTime _startDate;
  DateTime _updateDate;
  DateTime _endDate;
  bool _isAllDay;
  IconData? _icon;
  RecurrenceProperties? _recurrence;
  DateTime? _dayOfMonth;

  Task({
    required this.uuid,
    required this.mode,
    required String title,
    required DateTime startDate,
    required bool isAllDay,
    RecurrenceProperties? recurrence,
    DateTime? dayOfMonth,
    DateTime? endDate,
    int? repeat,
    String? description,
    String? owner,
    IconData? icon,
  })  : _title = title,
        _startDate = startDate,
        _endDate = endDate ?? startDate,
        _isAllDay = isAllDay,
        _recurrence = recurrence,
        _dayOfMonth = dayOfMonth,
        _repeat = repeat,
        _description = description,
        _owner = owner,
        _icon = icon,
        isCompleted = false,
        _updateDate = DateTime.now();

  Task.fromJson(Map<String, dynamic> json)
      : uuid = json['uuid'],
        mode = json['mode'],
        _title = json['title'],
        _description = json['description'],
        _owner = json['owner'],
        isCompleted = json['isCompleted'],
        _startDate = DateTime.parse(json['startDate']),
        _updateDate = DateTime.parse(json['updateDate']),
        _endDate = json['endDate'],
        _isAllDay = json['isAllDay'] ?? false,
        _recurrence = json['recurrence'],
        _icon = json['icon'] != null ? IconData(json['icon']) : null,
        _dayOfMonth = DateTime.parse(json['dayOfMonth']),
        _repeat = json['repeat'];

  void update({
    String? title,
    String? description,
    String? owner,
    bool? isCompleted,
    DateTime? startDate,
    DateTime? endDate,
    bool? isAllDay,
    RecurrenceProperties? recurrence,
    DateTime? dayOfMonth,
    List<bool>? weeklyDays,
    int? repeat,
    IconData? icon,
  }) {
    _title = title ?? _title;
    _description = description ?? _description;
    _owner = owner ?? _owner;
    this.isCompleted = isCompleted ?? this.isCompleted;
    _startDate = startDate ?? _startDate;
    _endDate = endDate ?? _endDate;
    _isAllDay = isAllDay ?? _isAllDay;
    _dayOfMonth = dayOfMonth ?? _dayOfMonth;
    _recurrence = recurrence ?? _recurrence;
    _icon = icon ?? _icon;
    _repeat = repeat ?? _repeat;
    _updateDate = DateTime.now();
  }

  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'mode': mode,
        'title': _title,
        'description': _description,
        'owner': _owner,
        'isCompleted': isCompleted,
        'startDate': _startDate.toIso8601String(),
        'updateDate': _updateDate.toIso8601String(),
        'endDate': _endDate.toIso8601String(),
        'isAllDay': _isAllDay,
        'recurrence': _recurrence,
        'dayOfMonth': _dayOfMonth?.toIso8601String(),
        'repeat': _repeat,
        'icon': _icon?.codePoint,
      };

  String? toRecurrenceRule() {
    if (_recurrence == null) {
      return null;
    }

    final buffer = StringBuffer('FREQ=');

    switch (_recurrence!.recurrenceType) {
      case RecurrenceType.daily:
        buffer.write('DAILY');
        break;
      case RecurrenceType.weekly:
        buffer.write('WEEKLY');
        buffer.write(';BYDAY=');
        buffer.write(_recurrence!.weekDays
            .map((day) => _weekdayToString(day))
            .join(','));
        break;
      case RecurrenceType.monthly:
        buffer.write('MONTHLY');
        buffer.write(';BYMONTHDAY=${_recurrence!.dayOfMonth}');
        break;
      case RecurrenceType.yearly:
        buffer.write('YEARLY');
        break;
    }

    buffer.write(';INTERVAL=${_recurrence!.interval}');

    if (_recurrence!.recurrenceRange == RecurrenceRange.count) {
      buffer.write(';COUNT=${_recurrence!.recurrenceCount}');
    } else if (_recurrence!.recurrenceRange == RecurrenceRange.endDate) {
      buffer.write(
          ';UNTIL=${_recurrence!.endDate!.toIso8601String().replaceAll('-', '').replaceAll(':', '').replaceAll('Z', '')}');
    }

    return buffer.toString();
  }

  String _weekdayToString(WeekDays day) {
    switch (day) {
      case WeekDays.sunday:
        return 'SU';
      case WeekDays.monday:
        return 'MO';
      case WeekDays.tuesday:
        return 'TU';
      case WeekDays.wednesday:
        return 'WE';
      case WeekDays.thursday:
        return 'TH';
      case WeekDays.friday:
        return 'FR';
      case WeekDays.saturday:
        return 'SA';
      default:
        return '';
    }
  }

  bool isRecurrenceOn(DateTime? date) {
    bool isOn = false;

    if (_recurrence != null) {
      DateTime d = date ?? DateTime.now();

      for (int i = 0; !isOn && i < _recurrence!.weekDays.length; i++) {
        if (d.weekday == 7) {
          isOn = _recurrence!.weekDays[i].index == 0;
        } else {
          isOn = d.weekday == _recurrence!.weekDays[i].index;
        }
      }

      if (!isOn && _recurrence!.recurrenceType == RecurrenceType.monthly) {
        isOn = d.day == _recurrence!.dayOfMonth;
      }
    }

    return isOn;
  }

  String get title => _title;
  String? get description => _description;
  String? get owner => _owner;
  DateTime get startDate => _startDate;
  DateTime get updateDate => _updateDate;
  DateTime get endDate => _endDate;
  bool get isAllDay => _isAllDay;
  RecurrenceProperties? get recurrence => _recurrence;
  DateTime? get dayOfMonth => _dayOfMonth;
  int? get repeat => _repeat;
  IconData? get icon => _icon;

  int compare(Task other) {
    return _startDate.compareTo(other.startDate);
  }

  @override
  String toString() {
    return 'Task{uuid: $uuid, mode: $mode, title: $_title, description: $_description, owner: $_owner, isCompleted: $isCompleted, startDate: $_startDate, updateDate: $_updateDate, endDate: $_endDate, isAllDay: $_isAllDay, recurrence: $_recurrence, monthlyDates: $_dayOfMonth, repeat: $_repeat}';
  }
}
