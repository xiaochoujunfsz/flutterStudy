import 'package:flutter/material.dart';

typedef ColorSelectCallback = void Function(Color color);

class ColorSelect extends StatefulWidget {
  final List<Color> colors;
  final double radius;
  final ColorSelectCallback onColorSelect;
  final Color defaultColor;

  const ColorSelect(
      {required this.colors,
      this.radius = 25,
      required this.defaultColor,
      required this.onColorSelect,
      Key? key})
      : super(key: key);

  @override
  State<ColorSelect> createState() => _ColorSelectState();
}

class _ColorSelectState extends State<ColorSelect> {
  int _selectedIndex = 0;

  Color get activeColor => widget.colors[_selectedIndex];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.colors.indexOf(widget.defaultColor);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 45,
      child: Wrap(
        spacing: 20,
        children: widget.colors
            .map((e) => GestureDetector(
                  onTap: () => _doSelectColor(e),
                  child: _buildItem(e),
                ))
            .toList(),
      ),
    );
  }

  // 执行选中方法，触发回调
  void _doSelectColor(Color color) {
    int index = widget.colors.indexOf(color);
    if (index == _selectedIndex) {
      return;
    }
    setState(() {
      _selectedIndex = index;
    });
    widget.onColorSelect.call(color);
  }

  // 构建圆圈
  Widget _buildItem(Color color) => Container(
        width: widget.radius,
        height: widget.radius,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        child: activeColor == color ? _buildActiveIndicator() : null,
      );

  // 构建白圆圈指示器
  Widget _buildActiveIndicator() => Container(
        width: widget.radius * 0.6,
        height: widget.radius * 0.6,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
      );
}
