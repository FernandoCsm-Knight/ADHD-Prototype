import 'package:flutter/material.dart';
import 'package:prototype/src/common/controller/task_controller.dart';
import 'package:prototype/src/common/types/view_mode.dart';
import 'package:prototype/src/home/components/next_event_card.dart';
import 'package:prototype/src/common/components/task_view.dart';
import 'package:prototype/src/settings/controller/view_mode_controller.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({ super.key});

  @override
  Widget build(BuildContext context) {
    final TaskController taskController = context.watch<TaskController>();
    final ViewMode view =  Provider.of<ViewModeController>(context).view;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NextEventCard(task: taskController.nextTaskFor(mode: view)),
          const SizedBox(height: 20),
          Center(
            child: Text(
              'Tarefas de hoje do ${view == ViewMode.parent ? 'João' : 'Gabriel'}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Expanded(child: TaskView()),
        ],
      ),
    );
  }
}
