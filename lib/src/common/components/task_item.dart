import 'package:flutter/material.dart';
import 'package:prototype/src/common/models/task.dart';
import 'package:prototype/src/common/controller/task_controller.dart';
import 'package:prototype/src/tasks/task_screen.dart';
import 'package:provider/provider.dart';

class TaskItem extends StatelessWidget {
  final Task task;

  const TaskItem({required this.task, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: Checkbox(
        value: task.isCompleted,
        onChanged: (bool? value) {
          Provider.of<TaskController>(context, listen: false).toggleTask(task);
        },
      ),
      onLongPress: () async {
        await Navigator.of(context).pushNamed(TaskScreen.routeName, arguments: task);
      },
      leading: task.icon != null ? Icon(task.icon) : null,
      title: Text(task.title),
    );
  }
}
