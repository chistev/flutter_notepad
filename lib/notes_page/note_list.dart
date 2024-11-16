import 'package:flutter/material.dart';
import '../note_list_item.dart';

class NoteList extends StatelessWidget {
  final List<Map<String, String>> notes;
  final Function(int index) onDelete;
  final Function(int index, String title, String note) onUpdate; // Added onUpdate

  const NoteList({
    Key? key,
    required this.notes,
    required this.onDelete,
    required this.onUpdate, // Added onUpdate in constructor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        return NoteListItem(
          title: notes[index]['title'] ?? '',
          note: notes[index]['note'] ?? '',
          date: notes[index]['date'] ?? '',
          onDelete: () => onDelete(index), // Pass the delete function with the index
          onUpdate: (title, note) => onUpdate(index, title, note), // Pass the update function with the index
        );
      },
    );
  }
}
