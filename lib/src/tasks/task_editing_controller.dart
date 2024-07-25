import 'package:flutter/material.dart';
import 'package:prototype/src/calendar/service/hour_form_field_controller.dart';
import 'package:prototype/src/calendar/service/routine_selector_controller.dart';
import 'package:prototype/src/common/models/task.dart';

class TaskEditingController with ChangeNotifier {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();
  final RoutineSelectorController routineController =
      RoutineSelectorController();

  final HourFormFieldController timeController = HourFormFieldController();

  late DateTime? _startDate;
  late DateTime? _endDate;

  late bool _isAllDay;
  late bool _isEditing;
  late bool _isComplete;

  TaskEditingController({
    required Task task,
  }) {
    titleController.text = task.title;
    descriptionController.text = task.description ?? '';
    _isEditing = false;
    _isAllDay = false;
    _isComplete = task.isCompleted;
    _startDate = task.startDate;
    _endDate = task.endDate;
  }

  bool get isAllDay {
    return _isAllDay;
  }

  set isAllDay(bool value) {
    _isAllDay = value;
    notifyListeners();
  }

  DateTime get endDate {
    final DateTime end = _endDate ?? DateTime.now();
    DateTime response;

    if (timeController.endTime != null) {
      response = DateTime(
        end.year,
        end.month,
        end.day,
        timeController.endTime!.hour,
        timeController.endTime!.minute,
      );
    } else {
      response = end;
    }

    return response;
  }

  set endDate(DateTime value) {
    _endDate = value;
    notifyListeners();
  }

  DateTime get startDate {
    final DateTime start = _startDate ?? DateTime.now();
    DateTime response;

    if (timeController.startTime != null) {
      response = DateTime(
        start.year,
        start.month,
        start.day,
        timeController.startTime!.hour,
        timeController.startTime!.minute,
      );
    } else {
      response = start;
    }

    return response;
  }

  set startDate(DateTime value) {
    _startDate = value;
    notifyListeners();
  }

  bool get isEditing {
    return _isEditing;
  }

  set isEditing(bool value) {
    _isEditing = value;
    notifyListeners();
  }

  bool get isComplete {
    return _isComplete;
  }

  set isComplete(bool value) {
    _isComplete = value;
    notifyListeners();
  }

  void toggleEditing() {
    isEditing = !isEditing;
    notifyListeners();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
    super.dispose();
  }
}
