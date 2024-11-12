import 'package:flutter/material.dart';
import 'note_list_item.dart';
import 'search_bar.dart';
import 'create_note_page.dart';
import 'package:intl/intl.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final FocusNode _searchFocusNode = FocusNode();
  final TextEditingController _searchController = TextEditingController();
  bool _showEmptyState = false;

  // Sample notes list
  final List<Map<String, String>> notes = [
    {"title": "https://coda.partnerlinks.io/ECNUSInfor...", "date": "16:14 PM, November 11, 2024"},
    {"title": "If I intend on building a notepad mobile a...", "date": "09:32 AM, November 11, 2024"},
    {"title": "November 5th", "date": "20:39 PM, November 10, 2024"},
    {"title": "Third shelf", "date": "16:58 PM, November 8, 2024"},
    {"title": "Second shelf", "date": "15:21 PM, November 8, 2024"},
    {"title": "Top shelf", "date": "15:11 PM, November 8, 2024"},
    {"title": "Software Development", "date": "17:47 PM, November 6, 2024"},
  ];

  List<Map<String, String>> _filteredNotes = [];

  @override
  void initState() {
    super.initState();
    _filteredNotes = notes;
    _searchController.addListener(_onSearchChanged);
    _searchFocusNode.addListener(() {
      setState(() {
        _showEmptyState = _searchFocusNode.hasFocus && _searchController.text.isEmpty;
      });
    });
  }

  void _onSearchChanged() {
    setState(() {
      if (_searchController.text.isEmpty) {
        _filteredNotes = notes;
      } else {
        _filteredNotes = notes.where((note) {
          return note['title']!.toLowerCase().contains(_searchController.text.toLowerCase());
        }).toList();
      }
      _showEmptyState = _filteredNotes.isEmpty;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  // Handle the back button to dismiss the keyboard
  Future<bool> _onBackPressed() async {
    if (_searchFocusNode.hasFocus) {
      _searchFocusNode.unfocus();
      return Future.value(false);
    }
    return Future.value(true);
  }

  // Function to add a new note at the top of the list
void _addNewNote(Map<String, String> newNote) {
  setState(() {
    // Format the current timestamp using the intl package
    final formattedDate = DateFormat('hh:mm a, MMMM dd, yyyy').format(DateTime.now());

    _filteredNotes.insert(0, {
      'title': newNote['title'] ?? '',  // Title (with fallback)
      'note': newNote['note'] ?? '',    // Note content (with fallback)
      'date': formattedDate,  // Timestamp formatted as a date
    });
  });
}


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Notes'),
          centerTitle: true,
        ),
        body: GestureDetector(
          onTap: () {
            if (_searchFocusNode.hasFocus) {
              FocusScope.of(context).requestFocus(FocusNode());
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SearchBar(
                  controller: _searchController,
                  focusNode: _searchFocusNode,
                  showEmptyState: _showEmptyState,
                ),
                const SizedBox(height: 16),
                _showEmptyState
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.search_off, color: Colors.grey[600], size: 48),
                            const SizedBox(height: 16),
                            Text(
                              "No notes",
                              style: TextStyle(color: Colors.grey[600], fontSize: 16),
                            ),
                          ],
                        ),
                      )
                    : Expanded(
  child: ListView.builder(
    itemCount: _filteredNotes.length,
    itemBuilder: (context, index) {
      return NoteListItem(
        title: _filteredNotes[index]['title'] ?? '', // Provide a fallback if 'title' is null
        note: _filteredNotes[index]['note'] ?? '',   // Provide a fallback if 'note' is null
        date: _filteredNotes[index]['date'] ?? '',   // Provide a fallback if 'date' is null
      );
    },
  ),
),

              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // Navigate to CreateNotePage and wait for the result
            final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreateNotePage()),
            );

            if (result != null) {
              // Add the new note to the list if data was returned
              _addNewNote(result);
            }
          },
          tooltip: 'Add Note',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
