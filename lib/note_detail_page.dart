import 'package:flutter/material.dart';

class NoteDetailPage extends StatefulWidget {
  final String title;
  final String date;

  const NoteDetailPage({
    Key? key,
    required this.title,
    required this.date,
  }) : super(key: key);

  @override
  _NoteDetailPageState createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  bool _isBottomSheetVisible = false;

  void _toggleBottomSheet() {
    if (_isBottomSheetVisible) {
      Navigator.of(context).pop();
    } else {
      _showShareOptions();
    }
    setState(() {
      _isBottomSheetVisible = !_isBottomSheetVisible;
    });
  }

  void _showShareOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.image_outlined),
              title: const Text('Share as Image'),
              onTap: () {
                // Define action for "Share as Image"
                Navigator.pop(context); // Close the bottom sheet
                setState(() {
                  _isBottomSheetVisible = false;
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.text_fields),
              title: const Text('Share as Text'),
              onTap: () {
                // Define action for "Share as Text"
                Navigator.pop(context); // Close the bottom sheet
                setState(() {
                  _isBottomSheetVisible = false;
                });
              },
            ),
          ],
        );
      },
    ).whenComplete(() {
      // Reset _isBottomSheetVisible when the BottomSheet closes
      setState(() {
        _isBottomSheetVisible = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes', style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.green),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          // Share icon
          IconButton(
            icon: const Icon(Icons.share_outlined, color: Colors.green),
            onPressed: _toggleBottomSheet, // Toggle the bottom sheet
          ),
          // Three-dot menu
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.grey),
            onPressed: () {
              // Define more options functionality here
              showMenu(
                context: context,
                position: const RelativeRect.fromLTRB(100, 50, 0, 0),
                items: [
                  const PopupMenuItem(value: 'option1', child: Text('Option 1')),
                  const PopupMenuItem(value: 'option2', child: Text('Option 2')),
                ],
              );
            },
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
            Text(
              'Title',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text(
              widget.title,
              style: const TextStyle(fontSize: 18, color: Colors.black),
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
              IconButton(
                icon: const Icon(Icons.share_outlined, color: Colors.grey),
                onPressed: _toggleBottomSheet, // Toggle the bottom sheet
              ),
            ],
          ),
        ),
      ),
    );
  }
}
