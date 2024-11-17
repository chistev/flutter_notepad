import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'note_detail_page/app_bar_widget.dart';
import 'note_detail_page/bottom_app_bar_widget.dart';
import 'note_detail_page/editable_text_field.dart';

class NoteDetailPage extends StatefulWidget {
  final String title;
  final String note;
  String date;
  final Function onDelete;
  final Function(String title, String note) onUpdate;

  NoteDetailPage({
    Key? key,
    required this.title,
    required this.note,
    required this.date,
    required this.onDelete,
    required this.onUpdate,
  }) : super(key: key);

  @override
  _NoteDetailPageState createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  late TextEditingController _titleController;
  late TextEditingController _noteController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.title);
    _noteController = TextEditingController(text: widget.note);
  }

  void _deleteNote() {
    widget.onDelete();
    Navigator.of(context).pop();
  }

  void _saveNote() {
    widget.onUpdate(_titleController.text, _noteController.text);
    setState(() {
      widget.date = DateFormat('hh:mm a, MMMM dd, yyyy').format(DateTime.now()); // Update the date when saving
      _isEditing = false;
    });
  }

  // Updated _launchURL method
  Future<void> _launchURL() async {
    final Uri url = Uri.parse('https://www.buymeacoffee.com/chistev12');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        isEditing: _isEditing,
        onEdit: () {
          setState(() {
            _isEditing = true;
          });
        },
        onSave: _saveNote,
        onDelete: _deleteNote,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.date, style: const TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 16),
            // Pass custom style to make the title bold
            EditableTextField(
              controller: _titleController,
              hintText: 'Title',
              isEditing: _isEditing,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black), // Bold title
              onTap: () {
                setState(() {
                  _isEditing = true; // Enable editing when tapped
                });
              },
            ),
            const SizedBox(height: 8),
            Expanded(
              child: EditableTextField(
                controller: _noteController,
                hintText: 'Note something down',
                isEditing: _isEditing,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                onTap: () {
                  setState(() {
                    _isEditing = true; // Enable editing when tapped
                  });
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBarWidget(onTap: _launchURL),
    );
  }
}
