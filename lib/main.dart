import 'package:animations/pages/circular_menu.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animaciones',
      home: CircularMenuPage(),
    );
  }
}
