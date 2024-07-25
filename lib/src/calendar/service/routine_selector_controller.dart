import 'package:flutter/material.dart';
import 'package:prototype/src/common/controller/week_routine_picker_controller.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class RoutineSelectorController with ChangeNotifier {
  bool _isAllDay = true;
  RecurrenceProperties? _frequency;

  final WeekRoutinePickerController weekController = WeekRoutinePickerController();

  bool get isAllDay => _isAllDay;
  RecurrenceProperties? get frequency => _frequency;

  WeekRoutinePickerController get weekRoutinePickerController => weekController;

  set isAllDay(bool isAllDay) {
    _isAllDay = isAllDay;
    notifyListeners();
  }

  set frequency(RecurrenceProperties? frequency) {
    _frequency = frequency;
    notifyListeners();
  }
}