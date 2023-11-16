import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'component/paint_setting_dialog.dart';
import 'model/line.dart';
import 'model/point.dart';
import 'paper_painter.dart';
import 'model/paint_model.dart';

enum TransformType {
  none, // 绘制状态
  translate, // 移动状态
  rotate, // 旋转状态
  scale, // 缩放状态
}

class WhitePaper extends StatefulWidget {
  const WhitePaper({super.key});

  @override
  State<WhitePaper> createState() => _WhitePaperState();
}

class _WhitePaperState extends State<WhitePaper> {
  final PaintModel paintModel = PaintModel();

  Color lineColor = Colors.black;
  double strokeWidth = 1;

  ValueNotifier<TransformType> type = ValueNotifier(TransformType.none);
  Matrix4 recodeMatrix = Matrix4.identity();
  Offset _offset = Offset.zero;
  static const List<IconData> icons = [
    Icons.edit,
    Icons.api,
    Icons.rotate_90_degrees_ccw_sharp,
    Icons.expand,
  ];

  @override
  void dispose() {
    paintModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      GestureDetector(
        onTap: _showSettingDialog,
        onScaleStart: _onScaleStart,
        onScaleUpdate: _onScaleUpdate,
        onScaleEnd: _onScaleEnd,
        onLongPressStart: _activeEdit,
        onLongPressUp: _cancelEdit,
        onLongPressMoveUpdate: _moveEdit,
        onDoubleTap: _clear,
        child: CustomPaint(
          size: MediaQuery.of(context).size,
          painter: PaperPainter(model: paintModel),
        ),
      ),
      Positioned(
        right: 20,
        top: 10,
        child: _buildTools(),
      )
    ]);
  }

  void _clear() {
    paintModel.clear();
  }

  void _showSettingDialog() {
    showCupertinoDialog(
        context: context,
        builder: (context) => PaintSettingDialog(
              onLineWidthSelect: _selectWidth,
              onColorSelect: _selectColor,
              initColor: lineColor,
              initWidth: strokeWidth,
            ));
  }

  void _selectWidth(double width) {
    strokeWidth = width;
  }

  void _selectColor(Color color) {
    lineColor = color;
  }

  void _activeEdit(LongPressStartDetails details) {
    paintModel.activeEditLine(Point.fromOffset(details.localPosition));
  }

  void _moveEdit(LongPressMoveUpdateDetails details) {
    paintModel.moveEditLine(details.offsetFromOrigin);
  }

  void _cancelEdit() {
    paintModel.cancelEditLine();
  }

  Widget _buildTools() {
    return ValueListenableBuilder(
        valueListenable: type,
        builder: (_, value, __) => Row(
              mainAxisSize: MainAxisSize.min,
              children: icons.asMap().keys.map((index) {
                bool active = value == TransformType.values[index];
                return IconButton(
                    onPressed: () => type.value = TransformType.values[index],
                    icon: Icon(icons[index],
                        color: active ? Colors.blue : Colors.grey));
              }).toList(),
            ));
  }

  void _onScaleStart(ScaleStartDetails details) {
    switch (type.value) {
      case TransformType.none:
        Line line = Line(color: lineColor, strokeWidth: strokeWidth);
        paintModel.pushLine(line);
        break;
      case TransformType.translate:
        if (details.pointerCount == 1) {
          _offset = details.focalPoint;
        }
        break;
      case TransformType.rotate:
        break;
      case TransformType.scale:
        break;
    }
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    switch (type.value) {
      case TransformType.none:
        paintModel.pushPoint(Point.fromOffset(details.localFocalPoint));
        break;
      case TransformType.translate:
        paintModel.matrix = Matrix4.translationValues(
                details.focalPoint.dx - _offset.dx,
                details.focalPoint.dy - _offset.dy,
                1)
            .multiplied(recodeMatrix);
        break;
      case TransformType.rotate:
        paintModel.matrix =
            recodeMatrix.multiplied(Matrix4.rotationZ(details.rotation));
        break;
      case TransformType.scale:
        if (details.scale == 1) return;
        paintModel.matrix = recodeMatrix.multiplied(
            Matrix4.diagonal3Values(details.scale, details.scale, 1));
        break;
    }
  }

  void _onScaleEnd(ScaleEndDetails details) {
    switch (type.value) {
      case TransformType.none:
        paintModel.doneLine();
        paintModel.removeEmpty();
        break;
      case TransformType.translate:
      case TransformType.rotate:
      case TransformType.scale:
        recodeMatrix = paintModel.matrix;
        break;
    }
  }
}
