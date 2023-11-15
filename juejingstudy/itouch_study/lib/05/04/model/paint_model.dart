import 'package:flutter/material.dart';

import 'line.dart';
import 'point.dart';

class PaintModel extends ChangeNotifier {
  final List<Line> _lines = [];

  final double tolerance = 8.0;

  List<Line> get lines => _lines;

  Line? get activeLine {
    try {
      return _lines.singleWhere((element) => element.state == PaintState.doing);
    } catch (e) {
      return null;
    }
  }

  void pushLine(Line line) {
    _lines.add(line);
  }

  void pushPoint(Point point, {bool force = false}) {
    if (activeLine == null) {
      return;
    }
    if (activeLine!.points.isNotEmpty && !force) {
      if ((point - activeLine!.points.last).distance < tolerance) return;
    }
    activeLine!.points.add(point);
    notifyListeners();
  }

  void doneLine() {
    if (activeLine == null) {
      return;
    }
    activeLine!.state = PaintState.done;
    notifyListeners();
  }

  void clear() {
    _lines.forEach((line) => line.points.clear());
    _lines.clear();
    notifyListeners();
  }

  void removeEmpty() {
    _lines.removeWhere((element) => element.points.isEmpty);
  }
}
