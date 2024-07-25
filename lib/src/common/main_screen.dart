import 'package:flutter/material.dart';
import 'package:prototype/src/calendar/screen/calendar_screen.dart';
import 'package:prototype/src/common/components/my_app_bar.dart';
import 'package:prototype/src/common/components/my_bottom_nav_bar.dart';
import 'package:prototype/src/home/home_screen.dart';
import 'package:prototype/src/routine/routines_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static const routeName = '/';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onItemTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: const [
          HomeScreen(),
          CalendarScreen(),
          RoutinesScreen(),
          Center(
            child: Text(
              'Em desenvolvimento...',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
      bottomNavigationBar: MyBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
