import 'package:flutter/material.dart';
import 'package:note_application/cubit/notes_cubit.dart';

import 'model/note.dart';

class NotePage extends StatefulWidget {
  final NotesCubit notesCubit;
  final Note? note;

  const NotePage({Key? key, required this.notesCubit, this.note})
      : super(key: key);

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  @override
  void initState() {
    super.initState();
    if (widget.note == null) return;
    _titleController.text = widget.note!.title;
    _bodyController.text = widget.note!.body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              key: const ValueKey('title'),
              controller: _titleController,
              autofocus: true,
              decoration: const InputDecoration(hintText: 'Title'),
            ),
            Expanded(
              child: TextField(
                key: const ValueKey('body'),
                controller: _bodyController,
                keyboardType: TextInputType.multiline,
                maxLines: 500,
                decoration:
                    const InputDecoration(hintText: 'Enter your text here...'),
              ),
            ),
            ElevatedButton(
              onPressed: () => _finishEditing(),
              child: const Text('ok'),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _bodyController.dispose();
  }

  _finishEditing() {
    if (widget.note != null) {
      widget.notesCubit.updateNote(
          widget.note!.id, _titleController.text, _bodyController.text);
    } else {
      widget.notesCubit.createNote(_titleController.text, _bodyController.text);
    }

    Navigator.pop(context);
  }

  _deleteNote() {
    widget.notesCubit.deleteNote(widget.note.id);
  }
}
