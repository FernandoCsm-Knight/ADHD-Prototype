import 'package:flutter/material.dart';
import 'package:prototype/src/calendar/components/hour_form_field.dart';
import 'package:prototype/src/calendar/components/routine_range_selector.dart';
import 'package:prototype/src/calendar/components/routine_selector.dart';
import 'package:prototype/src/common/controller/task_controller.dart';
import 'package:prototype/src/common/models/task.dart';
import 'package:prototype/src/common/types/view_mode.dart';
import 'package:prototype/src/tasks/task_editing_controller.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class TaskScreen extends StatefulWidget {
  static const routeName = '/task';

  final Task task;

  const TaskScreen({super.key, required this.task});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  late final TaskEditingController _controller;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DateTime? _dayOfMonth;

  @override
  void initState() {
    super.initState();
    _controller = TaskEditingController(task: widget.task);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final Task task = Task(
      uuid: widget.task.uuid,
      mode: widget.task.mode,
      title: _controller.titleController.text,
      startDate: _controller.startDate,
      endDate: _controller.endDate,
      isAllDay: _controller.isAllDay,
      description: _controller.descriptionController.text,
      recurrence: _controller.routineController.frequency,
      dayOfMonth: _dayOfMonth,
    );

    task.isCompleted = _controller.isComplete;

    Provider.of<TaskController>(context, listen: false).updateTask(task);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
    String title = widget.task.title;

    if (title.length > 20) {
      title = '${title.substring(0, 20)}...';
    }

    _controller.timeController.startTimeController.text =
        localizations.formatTimeOfDay(
      TimeOfDay.fromDateTime(widget.task.startDate),
    );

    _controller.timeController.endTimeController.text =
        localizations.formatTimeOfDay(
      TimeOfDay.fromDateTime(widget.task.endDate),
    );

    return ListenableBuilder(
        listenable: _controller,
        builder: (context, _) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                '${_controller.isEditing ? 'Editando:' : ''} $title',
                style: const TextStyle(fontSize: 18),
              ),
              actions: [
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                  margin: const EdgeInsets.only(right: 10),
                  child: Text(
                    widget.task.mode == ViewMode.parent ? 'Pai' : 'Criança',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 150,
                        width: double.infinity,
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: _controller.isComplete,
                                        onChanged: (bool? value) {
                                          if (_controller.isEditing &&
                                              value != null) {
                                            _controller.isComplete = value;
                                          }
                                        },
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: TextFormField(
                                          controller:
                                              _controller.titleController,
                                          readOnly: !_controller.isEditing,
                                          decoration: const InputDecoration(
                                            labelText: 'Título',
                                            border: UnderlineInputBorder(),
                                          ),
                                          validator: (String? value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Título é obrigatório';
                                            }

                                            return null;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  HourFormField(
                                    controller: _controller.timeController,
                                    readOnly: !_controller.isEditing,
                                  )
                                ],
                              ),
                            ),
                            widget.task.icon != null
                                ? Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: const EdgeInsets.all(8),
                                    margin: const EdgeInsets.only(
                                        left: 10, top: 10, bottom: 10),
                                    child: Center(
                                      child: Icon(widget.task.icon, size: 48),
                                    ),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _controller.descriptionController,
                        readOnly: !_controller.isEditing,
                        maxLines: 4,
                        minLines: 4,
                        decoration: const InputDecoration(
                          labelText: 'Descrição',
                        ),
                        validator: (String? value) {
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          const Text('Última atualização:'),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              localizations
                                  .formatFullDate(widget.task.updateDate),
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Visibility(
                        visible: widget.task.recurrence == null,
                        child: RoutineRangeSelector(
                          minYear: 2023,
                          maxYear: 2025,
                          startDate: _controller.startDate,
                          endDate: _controller.endDate,
                          onSelectionChanged:
                              (DateRangePickerSelectionChangedArgs args) {
                            if (args.value is PickerDateRange) {
                              final PickerDateRange range =
                                  args.value as PickerDateRange;
                              _controller.startDate =
                                  range.startDate ?? DateTime.now();
                              _controller.endDate =
                                  range.endDate ?? DateTime.now();
                            }
                          },
                        ),
                      ),
                      Visibility(
                        visible: widget.task.recurrence != null,
                        child: RoutineSelector(
                          controller: _controller.routineController,
                          onSelectionChanged:
                              (DateRangePickerSelectionChangedArgs args) {
                            if (args.value != null && args.value is PickerDateRange) {
                              final PickerDateRange range = args.value as PickerDateRange;
                              _dayOfMonth = range.startDate;
                            }
                          },
                          minYear: 2023,
                          maxYear: 2025,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Visibility(
                        visible: _controller.isEditing,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Provider.of<TaskController>(context,
                                        listen: false)
                                    .deleteTask(widget.task);
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Deletar',
                                style:
                                    TextStyle(fontSize: 16, color: Colors.red),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: _submit,
                              child: const Text(
                                'Salvar',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: _controller.toggleEditing,
              child:
                  Icon(_controller.isEditing ? Icons.visibility : Icons.edit),
            ),
          );
        });
  }
}
