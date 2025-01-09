import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class WeekRoutinePickerController with ChangeNotifier {
  final List<bool> _selectedDays = List<bool>.generate(7, (index) => false);
  final List<String> _daysOfWeek = ['D', 'S', 'T', 'Q', 'Q', 'S', 'S'];

  List<bool> get selectedDays => _selectedDays;
  List<String> get daysOfWeek => _daysOfWeek;
  List<WeekDays> get days {
    return List<WeekDays>.generate(7, (index) {
      return WeekDays.values[index];
    }).where((day) => _selectedDays[day.index]).toList();
  }

  void toggleDay(int index) {
    _selectedDays[index] = !_selectedDays[index];
    notifyListeners();
  }

  void setSelectedDays(List<bool> days) {
    if (days.length == 7) {
      for (int i = 0; i < 7; i++) {
        _selectedDays[i] = days[i];
      }
      notifyListeners();
    }
  }
}
