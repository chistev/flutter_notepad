import 'package:flutter/material.dart';
import 'note_list_item.dart';
import 'bottom_nav_bar.dart';
import 'search_bar.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  int _selectedIndex = 0;
  final FocusNode _searchFocusNode = FocusNode();
  final TextEditingController _searchController = TextEditingController();
  bool _showEmptyState = false;

  final List<Map<String, String>> notes = [
    {"title": "https://coda.partnerlinks.io/ECNUSInfor...", "date": "16:14 PM, November 11, 2024"},
    {"title": "If I intend on building a notepad mobile a...", "date": "09:32 AM, November 11, 2024"},
    {"title": "November 5th", "date": "20:39 PM, November 10, 2024"},
    {"title": "Third shelf", "date": "16:58 PM, November 8, 2024"},
    {"title": "Second shelf", "date": "15:21 PM, November 8, 2024"},
    {"title": "Top shelf", "date": "15:11 PM, November 8, 2024"},
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _searchFocusNode.addListener(() {
      setState(() {
        _showEmptyState = _searchFocusNode.hasFocus && _searchController.text.isEmpty;
      });
    });
  }

  void _onSearchChanged() {
    setState(() {
      _showEmptyState = _searchFocusNode.hasFocus && _searchController.text.isEmpty;
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
      // Unfocus the search field and dismiss the keyboard
      _searchFocusNode.unfocus();
      return Future.value(false); // Don't pop the screen
    }
    return Future.value(true); // Allow the back action if the keyboard is not visible
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
              FocusScope.of(context).requestFocus(FocusNode());  // Unfocus using FocusScope
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
                    ? Center(child: Text("", style: TextStyle(color: Colors.grey[600])))
                    : Expanded(
                        child: ListView.builder(
                          itemCount: notes.length,
                          itemBuilder: (context, index) {
                            return NoteListItem(
                              title: notes[index]['title']!,
                              date: notes[index]['date']!,
                            );
                          },
                        ),
                      ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add your note-creation logic here
          },
          tooltip: 'Add Note',
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: BottomNavBar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
        ),
      ),
    );
  }
}
