import 'package:flutter/material.dart';

class BottomAppBarWidget extends StatelessWidget {
  final VoidCallback onTap;

  BottomAppBarWidget({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        child: GestureDetector(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.coffee, color: Colors.brown, size: 28), // Coffee icon
              const SizedBox(width: 8),
              const Text(
                'Buy Me A Coffee',
                style: TextStyle(color: Colors.brown, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
