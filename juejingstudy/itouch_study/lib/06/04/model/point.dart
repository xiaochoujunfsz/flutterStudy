import 'dart:math';
import 'dart:ui';

class Point {
  final double x;
  final double y;

  const Point({required this.x, required this.y});

  double get distance => sqrt(x * x + y * y);

  Point operator -(Point other) => Point(x: x - other.x, y: y - other.y);

  factory Point.fromOffset(Offset offset) {
    return Point(x: offset.dx, y: offset.dy);
  }

  Offset toOffset() => Offset(x, y);
}
