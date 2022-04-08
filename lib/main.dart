import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_application/cubit/notes_cubit.dart';
import 'package:note_application/cubit/notes_states.dart';

void main() {
  runApp(
    MyHomePage(
      title: 'Notes',
      notesCubit: NotesCubit(),
    ),
  );
}

class MyHomePage extends StatelessWidget {
  final NotesCubit notesCubit;
  final String title;

  const MyHomePage({Key? key, required this.title, required this.notesCubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
          onPressed: () {},
          tooltip: 'Add',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
