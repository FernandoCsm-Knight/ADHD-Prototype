import 'package:flutter/material.dart';
import 'package:prototype/src/common/models/task.dart';
import 'package:prototype/src/settings/controller/view_mode_controller.dart';
import 'package:prototype/src/tasks/task_screen.dart';
import 'package:provider/provider.dart';

class NextEventCard extends StatelessWidget {
  final Task? task;
  const NextEventCard({this.task, super.key});

  String _timeRange({
    required DateTime startDate,
    required DateTime endDate,
    required BuildContext context,
  }) {
    String result = '';
    final MaterialLocalizations locale = MaterialLocalizations.of(context);

    if (startDate.hour != endDate.hour || startDate.minute != endDate.minute) {
      result =
          '${locale.formatTimeOfDay(TimeOfDay.fromDateTime(startDate))} - ${locale.formatTimeOfDay(TimeOfDay.fromDateTime(endDate))}';
    } else {
      result = locale.formatTimeOfDay(TimeOfDay.fromDateTime(startDate));
    }
    
    return result;
  }

  Widget _buildContent(BuildContext context) {
    Widget content = const SizedBox(
      height: 150,
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Nenhum evento próximo',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );

    if (task != null) {
      final List<String> months = [
        'janeiro',
        'fevereiro',
        'março',
        'abril',
        'maio',
        'junho',
        'julho',
        'agosto',
        'setembro',
        'outubro',
        'novembro',
        'dezembro',
      ];

      final DateTime startDate = task!.startDate;
      final DateTime endDate = task!.endDate;

      content = Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Próximo evento',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              task!.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            const Divider(color: Colors.white),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    const Icon(Icons.calendar_today, color: Colors.white),
                    const SizedBox(width: 5),
                    Text(
                      '${startDate.day} de ${months[startDate.month]}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.access_time, color: Colors.white),
                    const SizedBox(width: 5),
                    Text(
                      _timeRange(
                        context: context,
                        startDate: startDate,
                        endDate: endDate,
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    }

    return content;
  }

  @override
  Widget build(BuildContext context) {
    final ViewModeController viewController =
        Provider.of<ViewModeController>(context);

    return Card(
      color: Theme.of(context).primaryColor,
      child: Material(
        color: Colors.transparent,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: InkWell(
          onTap: viewController.toggleView,
          onLongPress: () {
            Navigator.pushNamed(context, TaskScreen.routeName, arguments: task);
          },
          child: _buildContent(context),
        ),
      ),
    );
  }
}
