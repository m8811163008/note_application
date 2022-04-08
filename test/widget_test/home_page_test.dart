import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:note_application/cubit/notes_cubit.dart';
import 'package:note_application/home_page.dart';
import 'package:note_application/model/note.dart';
import 'package:note_application/note_page.dart';

void main() {
  group('Home Page', () {
    _pumpTestWidget(WidgetTester tester, NotesCubit cubit) => tester.pumpWidget(
          MaterialApp(
            home: HomePage(title: 'Home', notesCubit: cubit),
          ),
        );

    testWidgets('empty state', (WidgetTester tester) async {
      await _pumpTestWidget(tester, NotesCubit());
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(ListTile), findsNothing);
    });

    testWidgets('update list when a note is added',
        (WidgetTester tester) async {
      var notesCubit = NotesCubit();
      await _pumpTestWidget(tester, notesCubit);
      var expectedTitle = 'note title';
      var expectedBody = 'note body';
      notesCubit.createNote(expectedTitle, expectedBody);
      notesCubit.createNote('another note', 'another note body');
      await tester.pump();

      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(ListTile), findsNWidgets(2));
      expect(find.text(expectedTitle), findsOneWidget);
      expect(find.text(expectedBody), findsOneWidget);
    });

    testWidgets('update list when a note is deleted',
        (WidgetTester tester) async {
      var notesCubit = NotesCubit();
      await _pumpTestWidget(tester, notesCubit);
      var expectedTitle = 'note title';
      var expectedBody = 'note body';
      notesCubit.createNote(expectedTitle, expectedBody);
      notesCubit.createNote('another note', 'another body');
      await tester.pump();

      notesCubit.deleteNote(1);
      await tester.pumpAndSettle();
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(ListTile), findsOneWidget);
      expect(find.text(expectedTitle), findsNothing);
    });

    //test add note page
    testWidgets('navigate to new page', (WidgetTester tester) async {
      var notesCubit = NotesCubit();
      await _pumpTestWidget(tester, notesCubit);
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      expect(find.byType(NotePage), findsOneWidget);
    });

    //in home page tests we can assert the list tapping action
    testWidgets('Navigate to note page in edit mode',
        (WidgetTester tester) async {
      var notesCubit = NotesCubit();
      await _pumpTestWidget(tester, notesCubit);
      var expectedTitle = 'note title';
      var expectedBody = 'note body';

      notesCubit.createNote(expectedTitle, expectedBody);
      await tester.pump();
      await tester.tap(find.byType(ListTile));
      await tester.pumpAndSettle();
      expect(find.byType(NotePage), findsOneWidget);
      expect(find.text(expectedTitle), findsOneWidget);
      expect(find.text(expectedBody), findsOneWidget);
    });
  });

  group('Note Page', () {
    _pumpTestWidget(WidgetTester tester, NotesCubit cubit,
            {required Note note}) =>
        tester.pumpWidget(
          MaterialApp(
            home: NotePage(notesCubit: cubit, note: note),
          ),
        );

    testWidgets('create in edit mode', (WidgetTester tester) async {
      var note = Note(1, 'my note', 'note body');
      await _pumpTestWidget(tester, NotesCubit(), note: note);
      expect(find.text(note.title), findsOneWidget);
      expect(find.text(note.body), findsOneWidget);
    });

    testWidgets('edit note', (WidgetTester tester) async {
      var cubit = NotesCubit()..createNote('my note', 'note body');
      await _pumpTestWidget(tester, cubit, note: cubit.state.notes.first);
      await tester.enterText(find.byKey(const ValueKey('title')), 'hi');
      await tester.enterText(find.byKey(const ValueKey('body')), 'there');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
      expect(cubit.state.notes, isNotEmpty);
      var note = cubit.state.notes.first;
      expect(note.title, 'hi');
      expect(note.body, 'there');
      expect(find.byType(NotePage), findsNothing);
    });
  });
}
