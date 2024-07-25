import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class MyDateRangePicker extends StatelessWidget {
  final Function(DateRangePickerSelectionChangedArgs)? onSelectionChanged;
  final DateRangePickerSelectionMode selectionMode;
  final int minYear;
  final int maxYear;
  final DateTime? startDate;
  final DateTime? endDate;

  const MyDateRangePicker({
    required this.onSelectionChanged,
    required this.minYear,
    required this.maxYear,
    required this.selectionMode,
    this.startDate,
    this.endDate,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SfDateRangePicker(      
      view: DateRangePickerView.month,
      minDate: DateTime(minYear),
      maxDate: DateTime(maxYear),
      initialSelectedRange: PickerDateRange(startDate, endDate),
      showTodayButton: true,
      showNavigationArrow: true,
      showActionButtons: true,
      selectionMode: DateRangePickerSelectionMode.range,
      onSelectionChanged: onSelectionChanged,
      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
      headerStyle: DateRangePickerHeaderStyle(
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
      ),
    );
  }
}
