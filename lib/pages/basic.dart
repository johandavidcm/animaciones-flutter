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
  double _start = 0;
  double _end = 100;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );
    _counter = Tween<double>(begin: _start, end: _end).animate(_controller);
    _counter.addListener(() {
      setState(() {});
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _startNewAnimatio() {
    _start = _end;
    _end = _end + 100;
    _counter = Tween<double>(begin: _start, end: _end).animate(_controller);
    _controller.forward(from: 0);
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
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            CupertinoButton(
              child: Text('Start'),
              onPressed: () {
                _startNewAnimatio();
              },
            )
          ],
        ),
      ),
    );
  }
}
