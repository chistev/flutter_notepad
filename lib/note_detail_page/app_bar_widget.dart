import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final bool isEditing;
  final VoidCallback onEdit;
  final VoidCallback onSave;
  final VoidCallback onDelete;

  AppBarWidget({
    required this.isEditing,
    required this.onEdit,
    required this.onSave,
    required this.onDelete,
  });

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Notes', style: TextStyle(color: Colors.black)),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.green),
        onPressed: () => Navigator.of(context).pop(),
      ),
      actions: [
        if (!isEditing)
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
                    onTap: onDelete,
                  ),
                ],
              );
            },
          ),
        if (isEditing)
          IconButton(
            icon: const Icon(Icons.check, color: Colors.green),
            onPressed: onSave,
          ),
      ],
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }
}
