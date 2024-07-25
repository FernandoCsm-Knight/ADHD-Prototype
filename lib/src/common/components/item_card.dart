import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final void Function(BuildContext)? onTap;
  const ItemCard(
      {required this.title, required this.icon, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Material(
        clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        child: InkWell(
          onTap: () => onTap?.call(context),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Icon(icon, size: 38)),
                Center(child: Text(title, textAlign: TextAlign.center)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
