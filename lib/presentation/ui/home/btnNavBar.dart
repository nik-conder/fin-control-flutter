import 'package:fin_control/presentation/ui/calculator/calculator_page.dart';
import 'package:flutter/material.dart';

import '../settings/settings_page.dart';
import 'home_page.dart';

class BtnNavBar extends StatefulWidget {
  const BtnNavBar({super.key});

  @override
  State<BtnNavBar> createState() => _BtnNavBarState();
}

class _BtnNavBarState extends State<BtnNavBar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    CalculatorPage(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Calculator',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
