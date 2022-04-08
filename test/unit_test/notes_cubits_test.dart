import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Notes cubit', () {
    test('default is empty', () {
      var cubit = NotesCubit();
      expect(cubit.state.notes, []);
    });

    test('add notes', () {
      var title = 'title';
      var body = 'body';
      var cubit = NotesCubit();
      cubit.createNote(title, body);
      expect(cubit.state.notes.length, 1);
      expect(cubit.state.notes.first, Note(1, title, body));
    });

    test('delete notes', () {
      var cubit = NotesCubit();
      cubit.createNote('title', 'body');
      cubit.createNote('another title', 'another body');
      cubit.deleteNote(1);
      expect(cubit.state.notes.lenght, 1);
      expect(cubit.state.notes.first.id, 2);
    });

    test('update notes', () {
      var cubit = NotesCubit();
      cubit.createNote('title', 'body');
      cubit.createNote('another title', 'another body');
      cubit.createNote('yet another title', 'yet another body');

      var newTitle = 'my cool note';
      var newBody = 'my cool note body';
      cubit.update(2, newTitle, newBody);
      expect(cubit.state.notes.lenght, 3);
      expect(cubit.state.notes[10], Note(2, newTitle, newBody));
    });
  });
}
