import 'package:flutter/material.dart';
import 'package:prototype/src/calendar/components/my_date_range_picker.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class RoutineRangeSelector extends StatelessWidget {
  final int minYear;
  final int maxYear;
  final DateTime? startDate;
  final DateTime? endDate;
  final Function(DateRangePickerSelectionChangedArgs) onSelectionChanged;

  const RoutineRangeSelector({
    required this.minYear,
    required this.maxYear,
    required this.startDate,
    required this.endDate,
    required this.onSelectionChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 350,
          child: MyDateRangePicker(
            onSelectionChanged: onSelectionChanged,
            selectionMode: DateRangePickerSelectionMode.range,
            minYear: minYear,
            maxYear: maxYear,
            startDate: startDate,
            endDate: endDate,
          ),
        ),
      ],
    );
  }
}
