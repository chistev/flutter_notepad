import 'package:flutter/material.dart';

class CreateNotePage extends StatefulWidget {
  @override
  _CreateNotePageState createState() => _CreateNotePageState();
}

class _CreateNotePageState extends State<CreateNotePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  bool _isKeywordEntered = false;  // Track whether a keyword has been typed

  @override
  void initState() {
    super.initState();
    _titleController.addListener(_updateKeywordStatus);
    _noteController.addListener(_updateKeywordStatus);
  }

  // Update the status based on whether either controller has non-empty trimmed text
  void _updateKeywordStatus() {
    setState(() {
      _isKeywordEntered = _titleController.text.trim().isNotEmpty || _noteController.text.trim().isNotEmpty;
    });
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.green),
          onPressed: () => Navigator.of(context).pop(),  // Go back without saving
        ),
        title: const Text(
          'Create Note',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          if (_isKeywordEntered)
            IconButton(
              icon: const Icon(Icons.check, color: Colors.green),
              onPressed: () {
                final title = _titleController.text.trim();
                final note = _noteController.text.trim();
                final timestamp = TimeOfDay.now().format(context);

                // Debugging: Print the data being returned
  print("Title: $title, Note: $note, Timestamp: $timestamp");

                // Pass the note data back to the NotesPage
                Navigator.pop(context, {'title': title, 'note': note, 'timestamp': timestamp});
              },
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${TimeOfDay.now().format(context)}',
              style: const TextStyle(color: Colors.grey, fontSize: 16),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _titleController,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              decoration: const InputDecoration(
                hintText: 'Title',
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: TextField(
                controller: _noteController,
                decoration: const InputDecoration(
                  hintText: 'Note something down',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                maxLines: null,
                keyboardType: TextInputType.multiline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
