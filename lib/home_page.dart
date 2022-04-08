import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_application/cubit/notes_cubit.dart';
import 'package:note_application/cubit/notes_states.dart';

class HomePage extends StatelessWidget {
  final NotesCubit notesCubit;
  final String title;

  const HomePage({Key? key, required this.title, required this.notesCubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: BlocBuilder<NotesCubit, NotesState>(
        bloc: notesCubit,
        builder: (context, state) => ListView.builder(
          itemCount: state.notes.length,
          itemBuilder: (context, index) {
            var note = state.notes[index];
            return ListTile(
              title: Text(note.title),
              subtitle: Text(note.body),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _goToNotePage(context),
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }

  _goToNotePage(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NotePage(notesCubit: notesCubit),
        ),
      );
}

class NotePage extends StatelessWidget {
  final NotesCubit notesCubit;
  const NotePage({Key? key, required this.notesCubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
