
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:writer_app/models/books_draft.dart';

class SettingsAppController extends ChangeNotifier{
  final  int _currentHour = DateTime.now().hour;
  String _imagePath = 'assests/morning.png';
  bool _useColor = true;
  bool get useColor => _useColor;
  SharedPreferences? _preferences;
  SharedPreferences? get preferences => _preferences;

  int get currentHour => _currentHour;
  String get imagePath => _imagePath;

  final Random _random = Random();

  /// default color
  Color _color = Color(0xFFFFD4EE);

   Random get random => _random;
   Color get color => _color;


   /// pastel colors for background selection
  void changeByRandomColor() {
    _useColor = true;
    notifyListeners();
    final random = Random();
    _color =  _color = Color.fromARGB(
      255,
      random.nextInt(128) + 128,
      random.nextInt(128) + 128,
      random.nextInt(128) + 128,
    );
    notifyListeners();
  }


  /// change image based on day of hours
  String getImageWallper() {
    _useColor = false;
    notifyListeners();
    if (_currentHour >= 0 && _currentHour < 11) {
      _imagePath = 'assests/morning.png';
    } else if (_currentHour >= 11 && _currentHour < 15) {
      _imagePath = 'assests/afternoon.png';
    } else if (_currentHour >= 15 && _currentHour < 20) {
      _imagePath = 'assests/sundown.png';
    } else {
      _imagePath = 'assests/midnight.png';
    }
    notifyListeners();
    return _imagePath;
  }


  /// сохранить выбранный файл в формате пдф на  устройство
  saveTextToPdf() {
    final pdf = Document();
  }


}