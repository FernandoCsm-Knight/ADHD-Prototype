import 'package:flutter/material.dart';

class InfoFormField extends StatelessWidget {
  final TextEditingController _titleController;
  final TextEditingController _descriptionController;

  const InfoFormField({
    required TextEditingController titleController,
    required TextEditingController descriptionController,
    super.key,
  }): _titleController = titleController,
      _descriptionController = descriptionController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: _titleController,
          decoration: const InputDecoration(
            labelText: 'Título',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor, insira um título';
            }

            return null;
          },
        ),
        const SizedBox(height: 20),
        TextFormField(
          controller: _descriptionController,
          keyboardType: TextInputType.multiline,
          maxLines: 4,
          minLines: 4,
          decoration: const InputDecoration(
            labelText: 'Descrição',
            alignLabelWithHint: true,
          ),
        ),
      ],
    );
  }
}
