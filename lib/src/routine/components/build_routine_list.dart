import 'package:flutter/material.dart';
import 'package:prototype/src/common/components/item_card.dart';
import 'package:prototype/src/common/controller/task_controller.dart';
import 'package:prototype/src/common/models/task.dart';
import 'package:prototype/src/common/types/view_mode.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:uuid/uuid.dart';

List<ItemCard> buildRoutineList(
    TaskController controller) {
  final DateTime now = DateTime.now();

  return [
    ItemCard(
      title: 'Escovar os dentes',
      icon: Icons.bubble_chart_rounded,
      onTap: (BuildContext context) {
        controller.addTask(
          Task(
            uuid: const Uuid().v8(),
            mode: ViewMode.child,
            title: 'Escovar os dentes',
            isAllDay: true,
            startDate: DateTime(now.year, now.month, now.day, 8, 0),
            icon: Icons.bubble_chart_rounded,
          ),
        );

        controller.addTask(
          Task(
            uuid: const Uuid().v8(),
            mode: ViewMode.child,
            title: 'Escovar os dentes',
            isAllDay: true,
            startDate: DateTime(now.year, now.month, now.day, 13, 0),
            icon: Icons.bubble_chart_rounded,
          ),
        );

        controller.addTask(
          Task(
            uuid: const Uuid().v8(),
            mode: ViewMode.child,
            title: 'Escovar os dentes',
            isAllDay: true,
            startDate: DateTime(now.year, now.month, now.day, 20, 0),
            icon: Icons.bubble_chart_rounded,
          ),
        );
        Navigator.pop(context);
      },
    ),
    ItemCard(
      title: 'Dever de casa',
      icon: Icons.note_alt,
      onTap: (BuildContext context) {
        controller.addTask(
          Task(
            uuid: const Uuid().v8(),
            mode: ViewMode.child,
            title: 'Dever de casa',
            isAllDay: false,
            startDate: DateTime(now.year, now.month, now.day, 13, 0),
            endDate: DateTime(now.year, now.month, now.day, 14, 0),
            icon: Icons.note_alt,
            recurrence: RecurrenceProperties(
              recurrenceType: RecurrenceType.weekly,
              interval: 1,
              weekDays: [
                WeekDays.monday,
                WeekDays.tuesday,
                WeekDays.wednesday,
                WeekDays.thursday,
                WeekDays.friday
              ],
              startDate: DateTime.now(),
            ),
          ),
        );
        Navigator.pop(context);
      },
    ),
    ItemCard(
      title: 'Arrumar o quarto',
      icon: Icons.bed,
      onTap: (BuildContext context) {
        controller.addTask(
          Task(
            uuid: const Uuid().v8(),
            mode: ViewMode.child,
            title: 'Arrumar o quarto',
            isAllDay: false,
            startDate: DateTime(now.year, now.month, now.day, 10, 0),
            icon: Icons.bed,
            recurrence: RecurrenceProperties(
              recurrenceType: RecurrenceType.weekly,
              interval: 1,
              weekDays: [WeekDays.saturday],
              startDate: DateTime.now(),
            ),
          ),
        );
        Navigator.pop(context);
      },
    ),
    ItemCard(
      title: 'Passear com o cachorro',
      icon: Icons.pets,
      onTap: (BuildContext context) {
        controller.addTask(
          Task(
            uuid: const Uuid().v8(),
            mode: ViewMode.child,
            title: 'Passear com o cachorro',
            isAllDay: true,
            startDate: DateTime(now.year, now.month, now.day, 15, 0),
            icon: Icons.pets,
            recurrence: RecurrenceProperties(
              recurrenceType: RecurrenceType.weekly,
              weekDays: [WeekDays.monday, WeekDays.wednesday, WeekDays.friday],
              startDate: DateTime.now(),
            ),
          ),
        );
        Navigator.pop(context);
      },
    ),
    ItemCard(
      title: 'Lavar louça',
      icon: Icons.bubble_chart,
      onTap: (BuildContext context) {
        controller.addTask(
          Task(
            uuid: const Uuid().v8(),
            mode: ViewMode.child,
            title: 'Lavar louça',
            isAllDay: false,
            startDate: DateTime(now.year, now.month, now.day, 20, 0),
            icon: Icons.bubble_chart,
            recurrence: RecurrenceProperties(
              recurrenceType: RecurrenceType.weekly,
              interval: 1,
              weekDays: [
                WeekDays.tuesday,
                WeekDays.thursday,
                WeekDays.saturday
              ],
              startDate: DateTime.now(),
            ),
          ),
        );
        Navigator.pop(context);
      },
    ),
    ItemCard(
      title: 'Estudar',
      icon: Icons.bookmark,
      onTap: (BuildContext context) {
        controller.addTask(
          Task(
            uuid: const Uuid().v8(),
            mode: ViewMode.child,
            title: 'Estudar',
            isAllDay: false,
            startDate: DateTime(now.year, now.month, now.day, 14, 0),
            endDate: DateTime(now.year, now.month, now.day, 16, 0),
            icon: Icons.bookmark,
            recurrence: RecurrenceProperties(
              recurrenceType: RecurrenceType.weekly,
              interval: 1,
              weekDays: [
                WeekDays.monday,
                WeekDays.tuesday,
                WeekDays.wednesday,
                WeekDays.thursday,
                WeekDays.friday
              ],
              startDate: DateTime.now(),
            ),
          ),
        );
        Navigator.pop(context);
      },
    ),
    ItemCard(
      title: 'Futbol',
      icon: Icons.sports_soccer,
      onTap: (BuildContext context) {
        controller.addTask(
          Task(
            uuid: const Uuid().v8(),
            mode: ViewMode.child,
            title: 'Futbol',
            isAllDay: false,
            startDate: DateTime(now.year, now.month, now.day, 16, 0),
            endDate: DateTime(now.year, now.month, now.day, 18, 0),
            icon: Icons.sports_soccer,
            recurrence: RecurrenceProperties(
              recurrenceType: RecurrenceType.weekly,
              interval: 1,
              weekDays: [WeekDays.thursday, WeekDays.thursday],
              startDate: DateTime.now(),
            ),
          ),
        );
        Navigator.pop(context);
      },
    ),
    ItemCard(
      title: 'Jogar video game',
      icon: Icons.sports_esports,
      onTap: (BuildContext context) {
        controller.addTask(
          Task(
            uuid: const Uuid().v8(),
            mode: ViewMode.child,
            title: 'Jogar video game',
            isAllDay: false,
            startDate: DateTime(now.year, now.month, now.day, 20, 0),
            endDate: DateTime(now.year, now.month, now.day, 22, 0),
            icon: Icons.sports_esports,
            recurrence: RecurrenceProperties(
              recurrenceType: RecurrenceType.weekly,
              interval: 1,
              weekDays: [WeekDays.friday, WeekDays.saturday],
              startDate: DateTime.now(),
            ),
          ),
        );
        Navigator.pop(context);
      },
    ),
    ItemCard(
      title: 'Assistir TV',
      icon: Icons.tv,
      onTap: (BuildContext context) {
        controller.addTask(
          Task(
            uuid: const Uuid().v8(),
            mode: ViewMode.child,
            title: 'Assistir TV',
            isAllDay: false,
            startDate: DateTime(now.year, now.month, now.day, 20, 0),
            endDate: DateTime(now.year, now.month, now.day, 22, 0),
            icon: Icons.tv,
            recurrence: RecurrenceProperties(
              recurrenceType: RecurrenceType.weekly,
              interval: 1,
              weekDays: [WeekDays.sunday, WeekDays.friday, WeekDays.saturday],
              startDate: DateTime.now(),
            ),
          ),
        );
        Navigator.pop(context);
      },
    ),
    ItemCard(
      title: 'Ler um livro',
      icon: Icons.menu_book,
      onTap: (BuildContext context) {
        controller.addTask(
          Task(
            uuid: const Uuid().v8(),
            mode: ViewMode.child,
            title: 'Ler um livro',
            isAllDay: false,
            startDate: DateTime(now.year, now.month, now.day, 21, 0),
            endDate: DateTime(now.year, now.month, now.day, 22, 0),
            icon: Icons.menu_book,
            recurrence: RecurrenceProperties(
              recurrenceType: RecurrenceType.weekly,
              interval: 1,
              weekDays: [
                WeekDays.monday,
                WeekDays.wednesday,
                WeekDays.thursday
              ],
              startDate: DateTime.now(),
            ),
          ),
        );
        Navigator.pop(context);
      },
    ),
    ItemCard(
      title: 'Natação',
      icon: Icons.pool,
      onTap: (BuildContext context) {
        controller.addTask(
          Task(
            uuid: const Uuid().v8(),
            mode: ViewMode.child,
            title: 'Natação',
            isAllDay: false,
            startDate: DateTime(now.year, now.month, now.day, 9, 0),
            endDate: DateTime(now.year, now.month, now.day, 10, 0),
            icon: Icons.pool,
            recurrence: RecurrenceProperties(
              recurrenceType: RecurrenceType.weekly,
              interval: 1,
              weekDays: [WeekDays.tuesday, WeekDays.thursday],
              startDate: DateTime.now(),
            ),
          ),
        );
        Navigator.pop(context);
      },
    ),
    ItemCard(
      title: 'Ir para a escola',
      icon: Icons.school,
      onTap: (BuildContext context) {
        controller.addTask(
          Task(
            uuid: const Uuid().v8(),
            mode: ViewMode.child,
            title: 'Ir para a escola',
            isAllDay: false,
            startDate: DateTime(now.year, now.month, now.day, 7, 0),
            endDate: DateTime(now.year, now.month, now.day, 12, 0),
            icon: Icons.school,
            recurrence: RecurrenceProperties(
              recurrenceType: RecurrenceType.weekly,
              interval: 1,
              weekDays: [
                WeekDays.monday,
                WeekDays.tuesday,
                WeekDays.wednesday,
                WeekDays.thursday,
                WeekDays.friday
              ],
              startDate: DateTime.now(),
            ),
          ),
        );

        Navigator.pop(context);
      },
    ),
    ItemCard(
      title: 'Lavar roupa',
      icon: Icons.local_laundry_service,
      onTap: (BuildContext context) {
        controller.addTask(
          Task(
            uuid: const Uuid().v8(),
            mode: ViewMode.child,
            title: 'Lavar roupa',
            isAllDay: false,
            startDate: DateTime(now.year, now.month, now.day, 10, 0),
            icon: Icons.local_laundry_service,
            recurrence: RecurrenceProperties(
              recurrenceType: RecurrenceType.weekly,
              interval: 1,
              weekDays: [WeekDays.saturday],
              startDate: DateTime.now(),
            ),
          ),
        );

        Navigator.pop(context);
      },
    ),
    ItemCard(
      title: 'Fazer compras',
      icon: Icons.shopping_cart,
      onTap: (BuildContext context) {
        controller.addTask(
          Task(
            uuid: const Uuid().v8(),
            mode: ViewMode.child,
            title: 'Fazer compras',
            isAllDay: false,
            startDate: DateTime(now.year, now.month, now.day, 10, 0),
            icon: Icons.shopping_cart,
            recurrence: RecurrenceProperties(
              recurrenceType: RecurrenceType.weekly,
              interval: 1,
              weekDays: [WeekDays.sunday],
              startDate: DateTime.now(),
            ),
          ),
        );

        Navigator.pop(context);
      },
    ),
  ];
}
