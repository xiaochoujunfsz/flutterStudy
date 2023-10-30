import 'package:flutter/material.dart';

class LongPressDemo extends StatelessWidget {
  const LongPressDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: _onLongPress,
      onLongPressStart: _onLongPressStart,
      onLongPressEnd: _onLongPressEnd,
      onLongPressUp: _onLongPressUp,
      onLongPressMoveUpdate: _onLongPressMoveUpdate,
      child: Container(
        width: 100,
        height: 100,
        color: Colors.blue,
      ),
    );
  }

  void _onLongPress() {
    print('-----_onLongPress---------');
  }

  void _onLongPressStart(LongPressStartDetails details) {
    print('-----_onLongPressStart-localPosition:--${details.localPosition}--'
        '--globalPosition:--${details.globalPosition}--');
  }

  void _onLongPressEnd(LongPressEndDetails details) {
    print('-----_onLongPressEnd--'
        '--localPosition:--${details.localPosition}--'
        '--globalPosition:--${details.globalPosition}--'
        '--velocity:--${details.velocity}--');
  }

  void _onLongPressUp() {
    print('-----_onLongPressUp---------');
  }

  void _onLongPressMoveUpdate(LongPressMoveUpdateDetails details) {
    print('_onLongPressMoveUpdate:'
        'localPosition:${parserOffset(details.localPosition)};'
        'globalPosition:${parserOffset(details.globalPosition)};'
        'offsetFromOrigin:${parserOffset(details.offsetFromOrigin)};'
        'localOffsetFromOrigin:${parserOffset(details.localOffsetFromOrigin)};');
  }

  String parserOffset(Offset offset) {
    return '(${offset.dx.toStringAsFixed(2)},${offset.dy.toStringAsFixed(2)})';
  }
}
