import 'package:flutter/material.dart';

//带图标的输入框
class InputWidget extends StatefulWidget {
  InputWidget(
      {super.key,
      this.hintText,
      this.iconData,
      this.onChanged,
      this.textStyle,
      this.controller,
      this.obscureText = false});

  final bool obscureText;
  final String? hintText;
  final IconData? iconData;
  final ValueChanged<String>? onChanged;
  final TextStyle? textStyle;
  final TextEditingController? controller;

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      //是否隐藏文本，即显示密码类型
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        //提示文本
        hintText: widget.hintText,
        //左侧外的图标
        icon: widget.iconData == null ? null : Icon(widget.iconData),
      ),
    );
  }
}
