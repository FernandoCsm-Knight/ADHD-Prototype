import 'package:flutter/material.dart';

class WeekDaySelectorController with ChangeNotifier {
  DateTime _selected = DateTime.now();
  DateTime _focus = DateTime.now();

  final List<String> daysOfWeek = [
    'Dom',
    'Seg',
    'Ter',
    'Qua',
    'Qui',
    'Sex',
    'Sab',
  ];

  void select(DateTime date) {
    _selected = date;
    notifyListeners();
  }

  void focus(DateTime date) {
    _focus = date;
    notifyListeners();
  }

  DateTime get selectedDay => _selected;
  DateTime get focusedDay => _focus;
}
