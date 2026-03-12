import 'package:flutter/material.dart';

class MoodProvider extends ChangeNotifier {

  String _mood = "neutral";

  String get mood => _mood;

  void setMood(String newMood) {
    _mood = newMood;
    notifyListeners();
  }
}