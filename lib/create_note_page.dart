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

    // Add listeners to both controllers to detect changes
    _titleController.addListener(_updateKeywordStatus);
    _noteController.addListener(_updateKeywordStatus);
  }

  // Update the status based on whether either controller has non-empty trimmed text
  void _updateKeywordStatus() {
    setState(() {
      // Check if either title or note has non-empty text after trimming whitespace
      _isKeywordEntered = _titleController.text.trim().isNotEmpty || _noteController.text.trim().isNotEmpty;
    });
  }

  @override
  void dispose() {
    // Clean up the controllers when the page is disposed
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
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Create Note',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          // Display the "tick" icon only if there's text entered (after trimming whitespace)
          if (_isKeywordEntered)
            IconButton(
              icon: const Icon(Icons.check, color: Colors.green),
              onPressed: () {
                // Add save note logic here if needed
                print("Note Saved");
              },
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display current time in the format shown in the screenshot
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
