import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class TransalateAnimationPage extends StatefulWidget {
  const TransalateAnimationPage({Key? key}) : super(key: key);

  @override
  _TransalateAnimationPageState createState() =>
      _TransalateAnimationPageState();
}

class _TransalateAnimationPageState extends State<TransalateAnimationPage>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _dy;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _dy = Tween<double>(begin: -300, end: 300).animate(_controller);
    _dy.addListener(() {
      setState(() {});
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Transform.translate(
        offset: Offset(0, _dy.value),
        child: Center(
          child: Container(
            color: Colors.blue,
            width: 200,
            height: 200,
          ),
        ),
      ),
    );
  }
}
