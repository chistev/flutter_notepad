import 'package:flutter/material.dart';
import 'note_detail_page.dart';

class NoteListItem extends StatelessWidget {
  final String title;
  final String note;
  final String date; // This is the timestamp

  const NoteListItem({
    Key? key,
    required this.title,
    required this.note,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(
          title.isNotEmpty ? title : _getNoteExcerpt(note),  // Show title or note excerpt
          style: const TextStyle(fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(date), // This will display the timestamp
        onTap: () {
          // Navigate to the detail page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NoteDetailPage(title: title.isNotEmpty ? title : _getNoteExcerpt(note), date: date),
            ),
          );
        },
      ),
    );
  }

  String _getNoteExcerpt(String note) {
    // Get the first 50 characters of the note as an excerpt
    return note.length > 50 ? '${note.substring(0, 50)}...' : note;
  }
}
