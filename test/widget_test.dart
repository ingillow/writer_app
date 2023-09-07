// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:writer_app/controller/books_draft_controller.dart';

import 'package:writer_app/main.dart';
import 'package:writer_app/models/books_draft.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  group('BooksDraftController', () {
    late MockSharedPreferences mockSharedPreferences;
    late BooksDraftController controller;

    setUp(() {
      mockSharedPreferences = MockSharedPreferences();
      controller = BooksDraftController();
      controller.preferences = mockSharedPreferences;
    });

    test('initSharedPref should populate drafts from SharedPreferences',
        () async {
      final expectedDraftsJson = [
        '{"header":"Draft 1","body":"Content 1","cover":"Cover 1","id":1}',
        '{"header":"Draft 2","body":"Content 2","cover":"Cover 2","id":2}',
      ];

      when(() => mockSharedPreferences.getStringList('book_drafts'))
          .thenReturn(expectedDraftsJson);

      await controller.initSharedPref();

      expect(controller.drafts.length, expectedDraftsJson.length);
      expect(controller.drafts[0].header, "Draft 1");
      expect(controller.drafts[1].body, "Content 2");

      controller.notifyListeners();
    });

    test(
        'save func should save the changing in the item without creating the new one item in list if ids are the same',
        () async {
          final existingDraft = BooksDraft(
            header: 'Existing Draft',
            body: 'Existing Content',
            cover: 'Existing Cover',
            id: 1, // ID of an existing draft
          );
          when(() => mockSharedPreferences.getStringList('book_drafts'))
              .thenReturn([existingDraft.toJsonString()]);

          await controller.initSharedPref();
          expect(controller.drafts.length, 1);
          expect(controller.drafts[0].header, 'Updated Draft');

        });
  });
}
