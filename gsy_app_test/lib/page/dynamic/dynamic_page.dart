import 'package:flutter/material.dart';

class DynamicPage extends StatefulWidget {
  DynamicPage({Key? super.key});

  @override
  State<DynamicPage> createState() => DynamicPageState();
}

class DynamicPageState extends State<DynamicPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("DynamicPage"),
    );
  }
}
