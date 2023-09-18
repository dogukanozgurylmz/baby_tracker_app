import 'package:flutter/material.dart';

class WebViewProvider extends ChangeNotifier {
  double _progress = 0;
  double get progress => _progress;
  void setProgress(int progress) {
    _progress = progress.roundToDouble();
    notifyListeners();
  }
}
