import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class RotateAnimationPage extends StatefulWidget {
  RotateAnimationPage({Key? key}) : super(key: key);

  @override
  _RotateAnimationPageState createState() => _RotateAnimationPageState();
}

class _RotateAnimationPageState extends State<RotateAnimationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _angle;
  late Animation<Color?> _color, _iconColor;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _angle =
        Tween<double>(begin: 0, end: 45 * math.pi / 180).animate(_controller);
    _color = ColorTween(begin: Color(0xFFF0f0f0), end: Colors.redAccent)
        .animate(_controller);
    _iconColor = ColorTween(begin: Colors.blue, end: Color(0xFFF0f0f0))
        .animate(_controller);
    _angle.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _onPressed() {
    if (_controller.isCompleted) {
      _controller.reverse();
    } else {
      _controller.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Transform.rotate(
          angle: _angle.value,
          child: CupertinoButton(
            color: _color.value,
            borderRadius: BorderRadius.circular(50.0),
            padding: EdgeInsets.all(10.0),
            child: Icon(
              Icons.add,
              size: 50,
              color: _iconColor.value,
            ),
            onPressed: _onPressed,
          ),
        ),
      ),
    );
  }
}
