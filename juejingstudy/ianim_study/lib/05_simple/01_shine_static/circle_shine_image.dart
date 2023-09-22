import 'package:flutter/material.dart';

class CircleShineImage extends StatefulWidget {
  final double maxBlurRadius;
  final Color color;
  final Duration duration;
  final Curve curve;
  final ImageProvider image;
  final double radius;

  const CircleShineImage(
      {Key? key,
      this.maxBlurRadius = 10,
      this.color = Colors.purple,
      this.duration = const Duration(milliseconds: 2000),
      this.curve = Curves.ease,
      required this.image,
      this.radius = 30})
      : super(key: key);

  @override
  State<CircleShineImage> createState() => _CircleShineImageState();
}

class _CircleShineImageState extends State<CircleShineImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.radius * 2,
      width: widget.radius * 2,
      decoration: BoxDecoration(
          image: DecorationImage(image: widget.image, fit: BoxFit.cover),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: widget.color,
              blurRadius: widget.maxBlurRadius,
              spreadRadius: 0,
            )
          ]),
    );
  }
}
