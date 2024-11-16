import 'package:flutter/material.dart';
import 'note_detail_page.dart';

class NoteListItem extends StatelessWidget {
  final String title;
  final String note;
  final String date;
  final VoidCallback onDelete;
  final Function(String title, String note) onUpdate;

  const NoteListItem({
    Key? key,
    required this.title,
    required this.note,
    required this.date,
    required this.onDelete,
    required this.onUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(
          title.isNotEmpty ? title : _getNoteExcerpt(note),
          style: const TextStyle(fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(date),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NoteDetailPage(
                title: title.isNotEmpty ? title : _getNoteExcerpt(note),
                note: note,
                date: date, // Pass the date here
                onDelete: onDelete,
                onUpdate: (newTitle, newNote) {
                  onUpdate(newTitle, newNote); // Update the note through onUpdate
                },
              ),
            ),
          );
        },
      ),
    );
  }

  String _getNoteExcerpt(String note) {
    return note.length > 50 ? '${note.substring(0, 50)}...' : note;
  }
}
  