import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  const MyBottomNavBar({required this.currentIndex, required this.onTap, super.key});


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: GNav(
        gap: 6,
        iconSize: 24,
        tabBorderRadius: 10,
        tabBackgroundColor: Colors.blue.withOpacity(0.1),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        duration: const Duration(milliseconds: 300),
        selectedIndex: currentIndex,
        onTabChange: onTap,
        tabs: [
          GButton(
            icon: Icons.home_outlined,
            backgroundColor: Theme.of(context).bottomAppBarTheme.color,
            text: 'Home',
          ),
          GButton(
            icon: Icons.calendar_month_outlined,
            backgroundColor: Theme.of(context).bottomAppBarTheme.color,
            text: 'Caneldário',
          ),
          GButton(
            icon: Icons.repeat_rounded,
            backgroundColor: Theme.of(context).bottomAppBarTheme.color,
            text: 'Rotinas',
          ),
          GButton(
            icon: Icons.person_outline,
            backgroundColor: Theme.of(context).bottomAppBarTheme.color,
            text: 'Perfil',
          ),
        ],
      ),
    );
  }
}
