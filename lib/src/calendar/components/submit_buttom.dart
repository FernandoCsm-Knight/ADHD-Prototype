import 'package:flutter/material.dart';

class SubmitButtom extends StatelessWidget {
  final void Function() onPressed;
  const SubmitButtom({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          style: ButtonStyle(
            padding: const WidgetStatePropertyAll(
              EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          onPressed: onPressed,
          child: const Text(
            'Adicionar',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }
}
