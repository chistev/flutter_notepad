import 'package:flutter/material.dart';

import '../note_list_item.dart';


class NoteList extends StatelessWidget {
  final List<Map<String, String>> notes;

  const NoteList({super.key, required this.notes});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        return NoteListItem(
          title: notes[index]['title'] ?? '',
          note: notes[index]['note'] ?? '',
          date: notes[index]['date'] ?? '',
        );
      },
    );
  }
}
