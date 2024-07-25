import 'package:flutter/material.dart';
import 'package:prototype/src/settings/controller/view_mode_controller.dart';
import 'package:provider/provider.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shadowColor: Colors.grey[300],
      elevation: 2,
      title: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Olá',
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            'João',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
            Provider.of<ViewModeController>(context, listen: false)
                .toggleView();
          },
          icon: const Icon(Icons.swap_horiz),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Material(
            shape: const CircleBorder(),
            clipBehavior: Clip.hardEdge,
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
              child: Ink(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(Icons.person, size: 30, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
