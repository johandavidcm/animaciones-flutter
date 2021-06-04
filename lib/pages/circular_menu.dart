import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;

class CircularMenuPage extends StatefulWidget {
  const CircularMenuPage({Key? key}) : super(key: key);

  @override
  _CircularMenuPageState createState() => _CircularMenuPageState();
}

class _CircularMenuPageState extends State<CircularMenuPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final decoratorWidth = 0.85 * size.width;
    final outDecoratorWith = decoratorWidth + 130;
    final int itemsCount = 6;
    final double step = math.pi / itemsCount;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
          child: Column(
            children: [
              Toolbar(),
              Expanded(
                  child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    right: -decoratorWidth / 2,
                    child: SvgPicture.asset(
                      'assets/decoration.svg',
                      width: decoratorWidth,
                    ),
                  ),
                  Positioned(
                    right: -outDecoratorWith / 2,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: outDecoratorWith,
                          height: outDecoratorWith,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border:
                                Border.all(width: 2, color: Colors.redAccent),
                          ),
                        ),
                        ...List.generate(
                          itemsCount,
                          (int index) {
                            final angle =
                                (math.pi / 2 + index * step) + (step / 2);
                            return MenuItem(
                              offset: Offset(
                                outDecoratorWith / 2 * math.cos(angle),
                                outDecoratorWith / 2 * math.sin(angle),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              )),
              Container(
                height: 50,
                color: Color(0xfff0f0f0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final Offset offset;

  const MenuItem({Key? key, required this.offset}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: offset,
      child: Stack(
        children: [
          Transform.translate(
            offset: Offset(
              -50,
              0,
            ),
            child: Text('Label'),
          ),
          CupertinoButton(
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.redAccent,
                shape: BoxShape.circle,
              ),
            ),
            padding: EdgeInsets.zero,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class Toolbar extends StatelessWidget {
  const Toolbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'What does your soul \nneed today?',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            child: Container(
              height: 50.0,
              width: 50.0,
              child: Center(
                child: Icon(Icons.person, color: Colors.black),
              ),
              decoration: BoxDecoration(
                color: Color(0xfff0f0f0),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(-10, 0),
                  ),
                ],
                border: Border.all(
                  width: 2,
                  color: Colors.redAccent,
                ),
              ),
            ),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
