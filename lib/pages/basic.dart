import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class BasicAnimationsPage extends StatefulWidget {
  BasicAnimationsPage({Key? key}) : super(key: key);

  @override
  _BasicAnimationsPageState createState() => _BasicAnimationsPageState();
}

class _BasicAnimationsPageState extends State<BasicAnimationsPage>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _counter;
  late Animation<Color?> _color;
  bool _isCompleted = false;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );
    _counter = Tween<double>(begin: 0, end: 100).animate(_controller);
    _color = TweenSequence([
      TweenSequenceItem(
        tween: ColorTween(begin: Colors.yellow, end: Colors.blue),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: ColorTween(begin: Colors.blue, end: Colors.red),
        weight: 50,
      ),
    ]).animate(_controller);
    _counter.addListener(() {
      setState(() {});
      _isCompleted = _controller.status == AnimationStatus.completed;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _counter.value.toStringAsFixed(2),
              style: TextStyle(
                fontSize: 40.0,
                color: _color.value,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            CupertinoButton(
              child: Text('Start'),
              onPressed: () {
                if (_isCompleted) {
                  _controller.reverse();
                } else {
                  _controller.forward(from: 0);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
