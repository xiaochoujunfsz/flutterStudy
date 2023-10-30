import 'package:flutter/material.dart';

class ScaleDemo extends StatelessWidget {
  const ScaleDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onScaleStart: _onScaleStart,
        onScaleUpdate: _onScaleUpdate,
        onScaleEnd: _onScaleEnd,
        child: Container(color: Colors.blue, height: 80));
  }

  void _onScaleStart(ScaleStartDetails details) {
    print('_onScaleStart:'
        'focalPoint:${parserOffset(details.focalPoint)};'
        'localFocalPoint:${parserOffset(details.localFocalPoint)};'
        'pointerCount:${details.pointerCount};');
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    print('_onScaleUpdate:'
        'focalPoint:${parserOffset(details.focalPoint)};'
        'localFocalPoint:${parserOffset(details.localFocalPoint)};'
        'pointerCount:${details.pointerCount};'
        'scale:${details.scale};'
        'horizontalScale:${details.horizontalScale};'
        'verticalScale:${details.verticalScale};'
        'rotation:${details.rotation};');
  }

  void _onScaleEnd(ScaleEndDetails details) {
    print('_onScaleEnd:'
        'velocity:${details.velocity};'
        'pointerCount:${details.pointerCount};');
  }

  String parserOffset(Offset offset) {
    return '(${offset.dx.toStringAsFixed(2)},${offset.dy.toStringAsFixed(2)})';
  }
}
