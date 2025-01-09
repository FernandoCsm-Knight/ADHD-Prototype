import 'package:flutter/material.dart';
import 'package:prototype/src/calendar/components/hour_form_field.dart';
import 'package:prototype/src/calendar/components/info_form_field.dart';
import 'package:prototype/src/calendar/components/routine_selector.dart';
import 'package:prototype/src/calendar/components/submit_buttom.dart';
import 'package:prototype/src/calendar/service/hour_form_field_controller.dart';
import 'package:prototype/src/calendar/service/routine_selector_controller.dart';
import 'package:prototype/src/common/controller/task_controller.dart';
import 'package:prototype/src/common/models/task.dart';
import 'package:prototype/src/routine/components/routines_list.dart';
import 'package:prototype/src/settings/controller/view_mode_controller.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:uuid/uuid.dart';

class AddRoutineScreen extends StatefulWidget {
  const AddRoutineScreen({super.key});

  @override
  State<AddRoutineScreen> createState() => _AddRoutineScreenState();
}

class _AddRoutineScreenState extends State<AddRoutineScreen> {
  final int _minYear = DateTime.now().year - 5;
  final int _maxYear = DateTime.now().year + 5;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final RoutineSelectorController _routineController =
      RoutineSelectorController();

  final DateTime _startDate = DateTime.now();
  DateTime? _dayOfMonth;
  DateTime? _endDate;

  final HourFormFieldController _timeController = HourFormFieldController();

  submit() {
    if (_formKey.currentState!.validate()) {
      final String title = _titleController.text;
      final String description = _descriptionController.text;
      _endDate ??= _startDate;

      final DateTime sDate = DateTime(
        _startDate.year,
        _startDate.month,
        _startDate.day,
        _timeController.startTime!.hour,
        _timeController.startTime!.minute,
      );

      final DateTime eDate = DateTime(
        _startDate.year,
        _startDate.month,
        _startDate.day,
        _timeController.endTime!.hour,
        _timeController.endTime!.minute,
      );

      final Task t = Task(
        uuid: const Uuid().v8(),
        mode: Provider.of<ViewModeController>(context, listen: false).view,
        title: title,
        startDate: sDate,
        endDate: eDate,
        description: description,
        isAllDay: false,
        dayOfMonth: _dayOfMonth,
        recurrence: _routineController.frequency,
      );

      Provider.of<TaskController>(context, listen: false).addTask(t);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Evento'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
          onPressed: () {
            Provider.of<ViewModeController>(context, listen: false)
                .toggleView();
          },
          icon: const Icon(Icons.swap_horiz),
        ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Text(
                  'Adicionar uma rotina predefinida: ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 20),
                RoutinesList(taskController: Provider.of<TaskController>(context, listen: false)),
                Divider(
                  color: Colors.grey[350],
                  height: 30,
                  thickness: 2,
                  indent: 0,
                  endIndent: 0,
                ),
                const SizedBox(height: 20),
                const Center(
                    child: Text(
                  'Criar uma rotina',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                )),
                const SizedBox(height: 20),
                InfoFormField(
                  titleController: _titleController,
                  descriptionController: _descriptionController,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Aplicar rotina',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 20),
                RoutineSelector(
                  controller: _routineController,
                  onSelectionChanged:
                      (DateRangePickerSelectionChangedArgs args) {
                    if (args.value != null && args.value is PickerDateRange) {
                      final PickerDateRange range = args.value as PickerDateRange;
                      _dayOfMonth = range.startDate;
                    }
                  },
                  minYear: _minYear,
                  maxYear: _maxYear,
                ),
                const SizedBox(height: 20),
                HourFormField(controller: _timeController),
                const SizedBox(height: 20),
                SubmitButtom(onPressed: submit),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
