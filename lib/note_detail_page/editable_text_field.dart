import 'package:flutter/material.dart';

class EditableTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isEditing;
  final int? maxLines;
  final TextInputType? keyboardType;
  final TextStyle? style;
  final VoidCallback onTap; // Add onTap callback to trigger editing

  EditableTextField({
    required this.controller,
    required this.hintText,
    required this.isEditing,
    this.maxLines,
    this.keyboardType,
    this.style,
    required this.onTap, // Ensure we pass the onTap function
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Trigger edit mode on tap
      child: TextField(
        controller: controller,
        enabled: isEditing,
        maxLines: maxLines,
        keyboardType: keyboardType,
        style: style,
        decoration: InputDecoration(
          border: isEditing ? InputBorder.none : InputBorder.none,
          hintText: hintText,
        ),
      ),
    );
  }
}
