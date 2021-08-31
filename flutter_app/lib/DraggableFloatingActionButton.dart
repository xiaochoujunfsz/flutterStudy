import 'package:flutter/material.dart';

typedef MoveCallBack = void Function(Offset nowOffset);

class DraggableFloatingActionButton extends StatefulWidget {
  final Widget child;
  final Offset initialOffset;
  final VoidCallback onPressed;
  final GlobalKey parentKey;
  final bool xCanDraggable;
  final bool yCanDraggable;
  final Alignment alignment;
  final MoveCallBack moveCallBack;

  DraggableFloatingActionButton({
    @required this.child,
    this.initialOffset,
    @required this.onPressed,
    @required this.parentKey,
    this.xCanDraggable = true,
    this.yCanDraggable = true,
    this.alignment = Alignment.topLeft,
    this.moveCallBack,
  });

  @override
  State<StatefulWidget> createState() => _DraggableFloatingActionButtonState();
}

class _DraggableFloatingActionButtonState
    extends State<DraggableFloatingActionButton> {
  final GlobalKey _key = GlobalKey();

  bool _isDragging = false;
  Offset _offset;
  Offset _minOffset;
  Offset _maxOffset;
  bool _xCanDraggable;
  bool _yCanDraggable;

  @override
  void initState() {
    super.initState();
    _offset = widget.initialOffset ?? Offset(0, 0);
    _xCanDraggable = widget.xCanDraggable;
    _yCanDraggable = widget.yCanDraggable;

    WidgetsBinding.instance?.addPostFrameCallback(_setBoundary);
  }

  void _setBoundary(_) {
    final RenderBox parentRenderBox =
        widget.parentKey.currentContext?.findRenderObject() as RenderBox;
    final RenderBox renderBox =
        _key.currentContext?.findRenderObject() as RenderBox;
    final Alignment alignment = widget.alignment;

    try {
      final Size parentSize = parentRenderBox.size;
      final Size size = renderBox.size;

      setState(() {
        _minOffset = const Offset(0, 0);
        _maxOffset = Offset(
            parentSize.width - size.width, parentSize.height - size.height);
        if (widget.initialOffset == null) {
          if (alignment == Alignment.topLeft) {
            _offset = Offset(0, 0);
          } else if (alignment == Alignment.topRight) {
            _offset = Offset(parentSize.width - size.width, 0);
          } else if (alignment == Alignment.bottomLeft) {
            _offset = Offset(0, parentSize.height - size.height);
          } else if (alignment == Alignment.bottomRight) {
            _offset = Offset(
                parentSize.width - size.width, parentSize.height - size.height);
          } else if (alignment == Alignment.centerRight) {
            _offset = Offset(parentSize.width - size.width,
                (parentSize.height - size.height) / 2);
          }
        }
      });
    } catch (e) {
      print('catch: $e');
    }
  }

  void _updatePosition(PointerMoveEvent pointerMoveEvent) {
    double newOffsetX;
    double newOffsetY;
    if (_xCanDraggable) {
      newOffsetX = _offset.dx + pointerMoveEvent.delta.dx;
      if (newOffsetX < _minOffset.dx) {
        newOffsetX = _minOffset.dx;
      } else if (newOffsetX > _maxOffset.dx) {
        newOffsetX = _maxOffset.dx;
      }
    } else {
      newOffsetX = _offset.dx;
    }

    if (_yCanDraggable) {
      newOffsetY = _offset.dy + pointerMoveEvent.delta.dy;
      if (newOffsetY < _minOffset.dy) {
        newOffsetY = _minOffset.dy;
      } else if (newOffsetY > _maxOffset.dy) {
        newOffsetY = _maxOffset.dy;
      }
    } else {
      newOffsetY = _offset.dy;
    }

    setState(() {
      _offset = Offset(newOffsetX, newOffsetY);
      widget.moveCallBack.call(_offset);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _offset.dx,
      top: _offset.dy,
      child: Listener(
        onPointerMove: (PointerMoveEvent pointerMoveEvent) {
          _updatePosition(pointerMoveEvent);

          setState(() {
            _isDragging = true;
          });
        },
        onPointerUp: (PointerUpEvent pointerUpEvent) {
          print('onPointerUp');

          if (_isDragging) {
            setState(() {
              _isDragging = false;
            });
          } else {
            widget.onPressed();
          }
        },
        child: Container(
          key: _key,
          child: widget.child,
        ),
      ),
    );
  }
}
