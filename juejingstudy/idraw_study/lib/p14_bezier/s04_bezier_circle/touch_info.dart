import 'package:flutter/material.dart';

class TouchInfo extends ChangeNotifier {
  final List<Offset> _points = [];
  int _selectIndex = -1;

  int get selectIndex => _selectIndex;

  set selectIndex(int value) {
    if (_selectIndex == value) return;
    _selectIndex = value;
    notifyListeners();
  }

  List<Offset> get points => _points;

  void addPoint(Offset point) {
    _points.add(point);
    notifyListeners();
  }

  void updatePoint(int index, Offset point) {
    _points[index] = point;
    notifyListeners();
  }

  void reset() {
    _points.clear();
    _selectIndex = -1;
    notifyListeners();
  }

  Offset? get selectPoint => _selectIndex == -1 ? null : _points[_selectIndex];
}
