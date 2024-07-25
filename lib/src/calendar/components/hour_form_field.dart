import 'package:flutter/material.dart';
import 'package:prototype/src/calendar/service/hour_form_field_controller.dart';

class HourFormField extends StatefulWidget {
  final bool? readOnly;
  final HourFormFieldController controller;

  const HourFormField({
    required this.controller,
    this.readOnly,
    super.key,
  });

  @override
  State<HourFormField> createState() => _HourFormFieldState();
}

class _HourFormFieldState extends State<HourFormField> {
  @override
  Widget build(BuildContext context) {
    final MaterialLocalizations localizations = MaterialLocalizations.of(context);

    return Row(
      children: [
        Expanded(
          child: ValueListenableBuilder<TextEditingValue>(
            valueListenable: widget.controller.startTimeController,
            builder: (context, value, child) {
              return TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Horário de Início',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                readOnly: true,
                controller: widget.controller.startTimeController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira uma hora de término';
                  }
                  return null;
                },
                onTap: () {
                  if (widget.readOnly != true) {
                    widget.controller.selectTime(context, true, localizations);
                  }
                },
              );
            },
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ValueListenableBuilder<TextEditingValue>(
            valueListenable: widget.controller.endTimeController,
            builder: (context, value, child) {
              return TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Horário de Término',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                readOnly: true,
                controller: widget.controller.endTimeController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira uma hora de início';
                  }
                  return null;
                },
                onTap: () {
                  if (widget.readOnly != true) {
                    widget.controller.selectTime(context, false, localizations);
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }
}