import 'package:flutter/material.dart';

class PointData extends ChangeNotifier {
  final List<double> values = [];

  void push(double value) {
    values.add(value);
    notifyListeners();
  }

  void clear() {
    values.clear();
    notifyListeners();
  }
}
