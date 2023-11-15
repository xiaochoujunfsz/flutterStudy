import 'dart:ui';

class Point {
  final double x;
  final double y;

  const Point({required this.x, required this.y});

  factory Point.fromOffset(Offset offset) {
    return Point(x: offset.dx, y: offset.dy);
  }

  Offset toOffset() => Offset(x, y);
}
