import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const BottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.note),
          label: 'Notes',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.check_circle_outline),
          label: 'To-dos',
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.green,
      onTap: onItemTapped,
    );
  }
}
