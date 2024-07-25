import 'package:flutter/material.dart';

class HourFormFieldController with ChangeNotifier {
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;

  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();

  HourFormFieldController();

  TimeOfDay? get endTime => _endTime;
  TimeOfDay? get startTime => _startTime;

  bool _timeOfDayisBefore(TimeOfDay time1, TimeOfDay time2) {
    final int m1 = time1.hour * 60 + time1.minute;
    final int m2 = time2.hour * 60 + time2.minute;
    return m1 < m2;
  }

  bool _timeOfDayisAfter(TimeOfDay time1, TimeOfDay time2) {
    final int m1 = time1.hour * 60 + time1.minute;
    final int m2 = time2.hour * 60 + time2.minute;
    return m1 > m2;
  }

  void selectTime(BuildContext context, bool isStartTime, MaterialLocalizations localizations) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (picked != null) {
      if (isStartTime && endTime != null && _timeOfDayisAfter(picked, endTime!)) {
        _endTime = picked;
        if ((endTime != null)) endTimeController.text = localizations.formatTimeOfDay(endTime!);
      } else if (!isStartTime && startTime != null && _timeOfDayisBefore(picked, startTime!)) {
        _startTime = picked;
        if ((startTime != null)) startTimeController.text = localizations.formatTimeOfDay(startTime!);
      }

      if (isStartTime) {
        _startTime = picked;
        if ((startTime != null)) startTimeController.text = localizations.formatTimeOfDay(startTime!);
      } else {
        _endTime = picked;
        if ((endTime != null)) endTimeController.text = localizations.formatTimeOfDay(endTime!);
      }
    }

    notifyListeners();
  }
}