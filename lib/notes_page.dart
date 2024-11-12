import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'notes_page/empty_state.dart';
import 'notes_page/note_list.dart';
import 'search_bar.dart';

import 'create_note_page.dart';

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
    {"title": "If I intend on building a notepad mobile...", "date": "09:32 AM, November 11, 2024"},
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

  // Function to add a new note at the top of the list
  void _addNewNote(Map<String, String> newNote) {
    setState(() {
      final formattedDate = DateFormat('hh:mm a, MMMM dd, yyyy').format(DateTime.now());

      _filteredNotes.insert(0, {
        'title': newNote['title'] ?? '',
        'note': newNote['note'] ?? '',
        'date': formattedDate,
      });
    });
  }

  Future<bool> _onBackPressed() async {
    if (_searchFocusNode.hasFocus) {
      _searchFocusNode.unfocus();
      return Future.value(false);
    }
    return Future.value(true);
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
                    ? const EmptyState()
                    : Expanded(
                        child: NoteList(notes: _filteredNotes),
                      ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreateNotePage()),
            );

            if (result != null) {
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
