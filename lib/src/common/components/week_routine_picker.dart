import 'package:flutter/material.dart';
import 'package:prototype/src/common/controller/week_routine_picker_controller.dart';

class WeekRoutinePicker extends StatefulWidget {
  final WeekRoutinePickerController controller;
  final Function? onDayTapped;

  const WeekRoutinePicker(
      {required this.onDayTapped, required this.controller, super.key});

  @override
  State<WeekRoutinePicker> createState() => _WeekRoutinePickerState();
}

class _WeekRoutinePickerState extends State<WeekRoutinePicker> {
  void _onDayTapped(int index) {
    widget.controller.toggleDay(index);
    widget.onDayTapped?.call();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, _) {
        return Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              widget.controller.daysOfWeek.length,
              (index) {
                return GestureDetector(
                  onTap: () => _onDayTapped(index),
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.controller.selectedDays[index]
                          ? Theme.of(context).primaryColor
                          : Colors.transparent,
                    ),
                    child: Text(
                      widget.controller.daysOfWeek[index],
                      style: TextStyle(
                        color: widget.controller.selectedDays[index]
                            ? Colors.white
                            : Colors.grey[700],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
