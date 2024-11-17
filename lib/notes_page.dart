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

  final List<Map<String, String>> notes = [
    {"title": "Note 1", "note": "Sample note", "date": "16:14 PM, November 11, 2024"},
    {"title": "Note 2", "note": "Another sample note", "date": "09:32 AM, November 11, 2024"},
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

  void _updateNoteAtIndex(int index, String title, String note) {
    setState(() {
      _filteredNotes[index]['title'] = title;
      _filteredNotes[index]['note'] = note;
      final formattedDate = DateFormat('hh:mm a, MMMM dd, yyyy').format(DateTime.now());
      _filteredNotes[index]['date'] = formattedDate;

      // Move the updated note to the top of the list
      final updatedNote = _filteredNotes.removeAt(index);
      _filteredNotes.insert(0, updatedNote);
    });
  }

  void _deleteNoteAtIndex(int index) {
    setState(() {
      _filteredNotes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      child: NoteList(
                        notes: _filteredNotes,
                        onDelete: _deleteNoteAtIndex,
                        onUpdate: _updateNoteAtIndex,
                      ),
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
    );
  }
}
