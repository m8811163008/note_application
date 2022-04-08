import 'dart:collection';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/note.dart';
import 'notes_states.dart';

class NotesCubit extends Cubit<NotesState> {
  List _notes = [];
  int autoIncrementId = 0;

  NotesCubit() : super(NotesState(UnmodifiableListView([])));

  void createNote(String title, String body) {
    _notes.add(Note(++autoIncrementId, title, body));
    emit(NotesState(UnmodifiableListView(_notes)));
  }

  void deleteNote(int id) {
    _notes = _notes.where((element) => element.id != id).toList();
    emit(NotesState(UnmodifiableListView(_notes)));
  }

  void updateNote(int id, String title, String body) {
    var noteIndex = _notes.indexWhere((element) => element.id == id);
    _notes.replaceRange(noteIndex, noteIndex + 1, [Note(id, title, body)]);
    emit(NotesState(UnmodifiableListView(_notes)));
  }
}
