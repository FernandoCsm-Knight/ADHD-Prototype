import 'package:flutter/material.dart';
import 'package:prototype/src/common/components/item_card.dart';
import 'package:prototype/src/common/controller/task_controller.dart';
import 'package:prototype/src/routine/components/build_routine_list.dart';
import 'package:prototype/src/routine/components/item_search_dialog.dart';

class RoutinesList extends StatelessWidget {
  final TaskController taskController;
  late final List<ItemCard> routines;

  RoutinesList({required this.taskController, super.key}) {
    routines = buildRoutineList(taskController);
  }

  Future<void> _showRoutineDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ItemSearchDialog(items: routines);
      },
    ).then((value) {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> list = [];

    list.addAll(routines.sublist(0, 6));

    list.add(
      TextButton(
        onPressed: () => _showRoutineDialog(context),
        style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        child: const Text(
          '... ver mais',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );

    return SizedBox(
      height: 100,
      width: double.infinity,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return list[index];
        },
        separatorBuilder: (context, index) {
          return const SizedBox(width: 12);
        },
        itemCount: list.length,
      ),
    );
  }
}
