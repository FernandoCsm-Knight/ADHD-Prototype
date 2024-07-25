import 'package:flutter/material.dart';
import 'package:prototype/src/calendar/components/my_date_range_picker.dart';
import 'package:prototype/src/calendar/service/routine_selector_controller.dart';
import 'package:prototype/src/common/components/week_routine_picker.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

enum OptionType { allDay, weekly, monthly, none }

class Option {
  final String label;
  final OptionType value;

  Option(this.label, this.value);
}

class RoutineSelector extends StatefulWidget {
  final RoutineSelectorController controller;
  final Function(DateRangePickerSelectionChangedArgs) onSelectionChanged;
  final int minYear;
  final int maxYear;

  const RoutineSelector({
    required this.onSelectionChanged,
    required this.controller,
    required this.minYear,
    required this.maxYear,
    super.key,
  });

  @override
  State<RoutineSelector> createState() => _RoutineSelectorState();
}

class _RoutineSelectorState extends State<RoutineSelector> {
  OptionType selectedOption = OptionType.allDay;

  Widget _buildRoutineOptions() {
    switch (selectedOption) {
      case OptionType.weekly:
        return WeekRoutinePicker(
          onDayTapped: () {
            widget.controller.frequency = RecurrenceProperties(
              recurrenceType: RecurrenceType.weekly,
              interval: 1,
              weekDays: widget.controller.weekController.days,
              startDate: DateTime.now(),
            );
          },
          controller: widget.controller.weekController,
        );
      case OptionType.monthly:
        return SizedBox(
          height: 350,
          child: MyDateRangePicker(
            minYear: widget.minYear,
            maxYear: widget.maxYear,
            selectionMode: DateRangePickerSelectionMode.single,
            onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
              widget.onSelectionChanged.call(args);

              if (args.value != null && args.value is PickerDateRange) {
                final PickerDateRange range = args.value as PickerDateRange;

                if (range.startDate != null) {
                  widget.controller.frequency = RecurrenceProperties(
                    recurrenceType: RecurrenceType.monthly,
                    interval: 1,
                    dayOfMonth: range.startDate!.day,
                    startDate: DateTime.now(),
                  );
                }
              }
            },
          ),
        );
      default:
        return Container();
    }
  }

  Function()? _buildOnTapFunction(OptionType type) {
    Function()? onTap;

    switch (type) {
      case OptionType.allDay:
        onTap = () {
          selectedOption = OptionType.allDay;
          widget.controller.isAllDay = true;
          widget.controller.frequency = null;
        };
        break;
      case OptionType.weekly:
        onTap = () {
          selectedOption = OptionType.weekly;
          widget.controller.isAllDay = false;
        };
        break;
      case OptionType.monthly:
        onTap = () {
          selectedOption = OptionType.monthly;
          widget.controller.isAllDay = false;
        };

      default:
    }

    return onTap;
  }

  @override
  Widget build(BuildContext context) {
    final options = [
      Option('Todo Dia', OptionType.allDay),
      Option('Toda Semana', OptionType.weekly),
      Option('Todo Mês', OptionType.monthly)
    ];

    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, _) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: options.map(
                (option) {
                  bool isSelected = selectedOption == option.value;
                  return GestureDetector(
                    onTap: _buildOnTapFunction(option.value),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: Text(
                        option.label,
                        style: TextStyle(
                          color: isSelected
                              ? Theme.of(context).primaryColor
                              : Colors.black,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
            const SizedBox(height: 20),
            _buildRoutineOptions(),
          ],
        );
      },
    );
  }
}
