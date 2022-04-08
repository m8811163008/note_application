import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:note_application/cubit/notes_cubit.dart';
import 'package:note_application/home_page.dart';
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
  });
}
