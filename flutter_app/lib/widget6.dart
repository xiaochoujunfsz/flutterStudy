
import 'package:flutter/material.dart';
import 'package:flutter_app/widget4.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("包与插件"),
      ),
      body: Center(
        child: Column(
          children: [
            GradientButton(
              child: Text("Texture"),
              colors: [Colors.orange, Colors.red],
              height: 50,
              onPressed: () {
                Navigator.pushNamed(context, "texture");
              },
            ),
          ],
        ),
      ),
    );
  }
}