import 'package:flutter/material.dart';
import 'package:note_application/cubit/notes_cubit.dart';

class NotePage extends StatefulWidget {
  final NotesCubit notesCubit;

  const NotePage({Key? key, required this.notesCubit}) : super(key: key);

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

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
    widget.notesCubit.createNote(_titleController.text, _bodyController.text);
    Navigator.pop(context);
  }
}
