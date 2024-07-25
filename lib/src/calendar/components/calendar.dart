import 'package:flutter/material.dart';
import 'package:prototype/src/common/controller/task_controller.dart';
import 'package:prototype/src/common/models/task_data_source.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  @override
  Widget build(BuildContext context) {
    TaskController controller = Provider.of<TaskController>(context);

    return SfCalendar(
      headerStyle: CalendarHeaderStyle(
        backgroundColor: Theme.of(context).canvasColor,
      ),
      timeRegionBuilder: (context, timeRegionDetails) {
        return Container(
          color: Colors.red.withOpacity(0.2),
          child: Center(
            child: Text(
              timeRegionDetails.region.text!,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
          ),
        );
      },
      view: CalendarView.month,
      dataSource: TaskDataSource(controller.events),
      showCurrentTimeIndicator: true,
      showDatePickerButton: true,
      showNavigationArrow: true,
      showTodayButton: true,
      monthViewSettings: const MonthViewSettings(
        appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
        appointmentDisplayCount: 4,
        showAgenda: true,
      ),
    );
  }
}
