import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:writer_app/models/books_draft.dart';

class BooksDraftController extends ChangeNotifier{
  SharedPreferences? _preferences;

  SharedPreferences? get preferences => _preferences;
  final TextEditingController _editingControllerBody = TextEditingController();
  final TextEditingController _editingControllerHeader = TextEditingController();
  TextEditingController get editingController => _editingControllerBody;
  TextEditingController get editingControllerHeader => _editingControllerHeader;


  List<BooksDraft> _drafts = [
    BooksDraft(header: 'New book', body: "Vey long text with your masterpiece", cover: "Some cover", id: 1)
  ];

  List<BooksDraft> get drafts => _drafts;


  Future<void> initSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> draftsJson = prefs.getStringList('book_drafts') ?? [];
    _drafts = draftsJson.map((json) => BooksDraft.fromJson(jsonDecode(json))).toList();
    notifyListeners();
  }

  Future<void> saveDraft(BooksDraft draft) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    int existingIndex = _drafts.indexWhere((existingDraft) => existingDraft.id == draft.id);

    if (existingIndex != -1) {
      _drafts[existingIndex] = draft;
    } else {
      _drafts.add(draft);
    }

    List<String> draftsJson = _drafts.map((draft) => jsonEncode(draft.toJson())).toList();
    await prefs.setStringList('book_drafts', draftsJson);
    notifyListeners();
  }


  Future<void> deleteDraft(BooksDraft draft) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _drafts.remove(draft);
    List<String> draftsJson = _drafts.map((draft) => jsonEncode(draft.toJson())).toList();
    await prefs.setStringList('book_drafts', draftsJson);
    notifyListeners();
  }


  Future<void> saveText(String text) async {

    final draft = BooksDraft(
      header: _editingControllerHeader.text,
      body: _editingControllerBody.text,
      cover: 'Cover',
      id: -1,
    );

    _drafts.add(draft);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> draftsJson = _drafts.map((draft) => jsonEncode(draft.toJson())).toList();
    await prefs.setStringList('book_drafts', draftsJson);

    notifyListeners();
  }


}