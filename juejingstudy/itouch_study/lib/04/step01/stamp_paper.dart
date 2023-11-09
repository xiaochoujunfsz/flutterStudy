import 'package:flutter/material.dart';

class StampPaper extends StatefulWidget {
  const StampPaper({Key? key}) : super(key: key);

  @override
  State<StampPaper> createState() => _StampPaperState();
}

class _StampPaperState extends State<StampPaper> {
  final StampData stamps = StampData();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _removeLast,
      onDoubleTap: _clear,
      child: CustomPaint(
        painter: StampPainter(stamps: stamps),
        size: MediaQuery.of(context).size,
      ),
    );
  }

  void _onTapDown(TapDownDetails details) {
    stamps.push(Stamp(center: details.localPosition, color: Colors.grey));
  }

  void _onTapUp(TapUpDetails details) {
    stamps.activeLast();
  }

  void _removeLast() {
    stamps.removeLast();
  }

  void _clear() {
    stamps.clear();
  }

  @override
  void dispose() {
    stamps.dispose();
    super.dispose();
  }
}

class StampPainter extends CustomPainter {
  final StampData stamps;
  final Paint _paint = Paint();

  StampPainter({required this.stamps}) : super(repaint: stamps);

  @override
  void paint(Canvas canvas, Size size) {
    for (var element in stamps.stamps) {
      canvas.drawCircle(
          element.center, element.radius, _paint..color = element.color);
    }
  }

  @override
  bool shouldRepaint(covariant StampPainter oldDelegate) {
    return stamps != oldDelegate.stamps;
  }
}

class Stamp {
  Color color;
  Offset center;
  double radius;

  Stamp({this.color = Colors.blue, required this.center, this.radius = 20});
}

class StampData extends ChangeNotifier {
  final List<Stamp> stamps = [];

  void push(Stamp stamp) {
    stamps.add(stamp);
    notifyListeners();
  }

  void removeLast() {
    stamps.removeLast();
    notifyListeners();
  }

  void activeLast() {
    stamps.last.color = Colors.blue;
    notifyListeners();
  }

  void clear() {
    stamps.clear();
    notifyListeners();
  }
}
