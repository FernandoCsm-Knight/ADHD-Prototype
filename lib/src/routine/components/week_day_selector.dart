import 'package:flutter/material.dart';
import 'package:prototype/src/common/controller/task_controller.dart';
import 'package:prototype/src/routine/week_day_selector_controller.dart';
import 'package:prototype/src/settings/controller/locale_controller.dart';
import 'package:prototype/src/settings/controller/view_mode_controller.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class WeekDaySelector extends StatefulWidget {
  final WeekDaySelectorController controller;
  final Function()? onDayTapped;

  const WeekDaySelector(
      {required this.controller, this.onDayTapped, super.key});

  @override
  State<WeekDaySelector> createState() => _WeekDaySelectorState();
}

class _WeekDaySelectorState extends State<WeekDaySelector> {
  void _onDayTapped(DateTime selectedDay, DateTime focusedDay) {
    widget.controller.select(selectedDay);
    widget.controller.focus(focusedDay);
    widget.onDayTapped?.call();
  }

  @override
  Widget build(BuildContext context) {
    TaskController taskController = Provider.of<TaskController>(context);

    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, _) {
        return TableCalendar(
          focusedDay: widget.controller.focusedDay,
          firstDay: DateTime.now().subtract(const Duration(days: 365)),
          lastDay: DateTime.now().add(const Duration(days: 365)),
          calendarFormat: CalendarFormat.week,
          calendarBuilders: CalendarBuilders(
            markerBuilder: (context, day, events) {
              final dayTasks = taskController.routines.where((task) {
                final recurrenceRule = task.toRecurrenceRule();
                bool response = task.mode == Provider.of<ViewModeController>(context, listen: false).view;

                if (response) {
                  response = recurrenceRule != null && task.isRecurrenceOn(day) || task.isAllDay;
                }

                return response;
              },).toList();

              if (dayTasks.isNotEmpty) {
                return Positioned(
                  bottom: 1,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorLight,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${dayTasks.length}',
                        style: const TextStyle().copyWith(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                );
              }
              return null;
            },
          ),
          selectedDayPredicate: (day) {
            return isSameDay(widget.controller.selectedDay, day);
          },
          onDaySelected: _onDayTapped,
          availableCalendarFormats: const {
            CalendarFormat.week: 'Semana',
          },
          headerStyle: const HeaderStyle(
            titleCentered: true,
          ),
          locale: Provider.of<LocaleController>(context, listen: false)
              .locale
              .languageCode,
        );
      },
    );
  }
}
