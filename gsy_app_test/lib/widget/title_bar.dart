import 'package:flutter/material.dart';

class TitleBar extends StatelessWidget {
  final String? title;

  final IconData? iconData;

  final ValueChanged? onRightIconPressed;

  final bool needRightLocalIcon;

  final Widget? rightWidget;

  final GlobalKey rightKey = GlobalKey();

  TitleBar(this.title, {
    this.iconData,
    this.onRightIconPressed,
    this.needRightLocalIcon = false,
    this.rightWidget,
  });

  @override
  Widget build(BuildContext context) {
    Widget? widget = rightWidget;
    if (rightWidget == null) {
      widget = (needRightLocalIcon)
          ? IconButton(
        onPressed: () {
          RenderBox renderBox =
          rightKey.currentContext?.findRenderObject() as RenderBox;
          //将坐标变换从局部参考转换为全局参考
          var position = renderBox.localToGlobal(Offset.zero);
          var size = renderBox.size;
          var centerPosition = Offset(
            position.dx + size.width / 2,
            position.dy + size.height / 2,
          );
          onRightIconPressed?.call(centerPosition);
        },
        icon: Icon(
          iconData,
          key: rightKey,
          size: 19.0,
        ),
      )
          : Container();
    }
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Text(
              title!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          widget!
        ],
      ),
    );
  }
}
