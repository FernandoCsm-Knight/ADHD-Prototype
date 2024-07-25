import 'package:flutter/material.dart';
import 'package:prototype/src/common/components/task_view.dart';
import 'package:prototype/src/common/types/task_view_mode.dart';
import 'package:prototype/src/routine/add_routine_screen.dart';
import 'package:prototype/src/routine/components/week_day_selector.dart';
import 'package:prototype/src/routine/week_day_selector_controller.dart';

class RoutinesScreen extends StatefulWidget {
  const RoutinesScreen({super.key});

  @override
  State<RoutinesScreen> createState() => _RoutinesScreenState();
}

class _RoutinesScreenState extends State<RoutinesScreen> {
  final WeekDaySelectorController _controller = WeekDaySelectorController();

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _controller,
      builder: (context, _) {
        return Scaffold(
          body: Column(
            children: [
              WeekDaySelector(controller: _controller),
              Expanded(
                child: TaskView(
                  mode: TaskViewMode.onlyRoutines,
                  date: _controller.selectedDay,
                ),
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddRoutineScreen(),
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
