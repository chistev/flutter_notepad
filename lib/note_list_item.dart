import 'package:flutter/material.dart';
import 'note_detail_page.dart';

class NoteListItem extends StatelessWidget {
  final String title;
  final String date;

  const NoteListItem({
    Key? key,
    required this.title,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(date),
        onTap: () {
          // Navigate to the detail page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NoteDetailPage(title: title, date: date),
            ),
          );
        },
      ),
    );
  }
}
