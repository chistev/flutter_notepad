import 'package:flutter/material.dart';

class NoteDetailPage extends StatefulWidget {
  final String title;
  final String note;
  final String date;
  final Function onDelete;
  final Function(String title, String note) onUpdate;

  const NoteDetailPage({
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
    Navigator.of(context).pop();
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
      appBar: AppBar(
        title: const Text(
          'Notes',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.green),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          // Only show the three vertical dots when not in editing mode
          if (!_isEditing)
            IconButton(
              icon: const Icon(Icons.more_vert, color: Colors.green),
              onPressed: () {
                showMenu(
                  context: context,
                  position: const RelativeRect.fromLTRB(100, 50, 0, 0),
                  items: [
                    PopupMenuItem(
                      value: 'delete',
                      child: const Text('Delete'),
                      onTap: _deleteNote,
                    ),
                  ],
                );
              },
            ),
          // Show the "check" icon button when in edit mode
          if (_isEditing)
            IconButton(
              icon: const Icon(Icons.check, color: Colors.green),
              onPressed: _saveNote,
            ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.date,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                setState(() {
                  _isEditing = true;
                });
              },
              child: TextField(
                controller: _titleController,
                enabled: _isEditing,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  border: _isEditing ? InputBorder.none : InputBorder.none, // Explicitly set InputBorder.none
                  hintText: 'Title',
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isEditing = true;
                  });
                },
                child: TextField(
                  controller: _noteController,
                  enabled: _isEditing,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    border: _isEditing ? InputBorder.none : InputBorder.none, // Explicitly set InputBorder.none
                    hintText: 'Note something down',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(Icons.photo_album_outlined, color: Colors.grey),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.check_circle_outline, color: Colors.grey),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.notifications_outlined, color: Colors.grey),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
