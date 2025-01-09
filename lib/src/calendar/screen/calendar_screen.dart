import 'package:flutter/material.dart';
import 'package:prototype/src/calendar/screen/add_event_screen.dart';
import 'package:prototype/src/calendar/components/calendar.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  static const String routeName = '/calendar';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Calendar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddEventScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
