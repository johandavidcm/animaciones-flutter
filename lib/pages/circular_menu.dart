import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;

class MenuOption {
  final String label;
  final IconData iconData;

  MenuOption({
    required this.label,
    required this.iconData,
  });
}

class CircularMenuPage extends StatefulWidget {
  const CircularMenuPage({Key? key}) : super(key: key);

  @override
  _CircularMenuPageState createState() => _CircularMenuPageState();
}

class _CircularMenuPageState extends State<CircularMenuPage>
    with TickerProviderStateMixin {
  List<MenuOption> _options = [];

  late AnimationController _controller;
  late Animation<double> _animatedAngle;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animatedAngle =
        Tween<double>(begin: -math.pi, end: 0).animate(_controller);
    _animatedAngle.addListener(() {
      setState(() {});
    });
    _options.add(MenuOption(label: "Camera", iconData: Icons.camera));
    _options.add(MenuOption(label: "Comments", iconData: Icons.comment));
    _options
        .add(MenuOption(label: "Accessibility", iconData: Icons.accessibility));
    _options.add(MenuOption(label: "Food", iconData: Icons.cake));
    _options.add(MenuOption(label: "Favorite", iconData: Icons.favorite));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final decoratorWidth = 0.85 * size.width;
    final outDecoratorWith = decoratorWidth + 130;
    final int itemsCount = _options.length;
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
                    child: Transform.rotate(
                      angle: _animatedAngle.value,
                      child: SvgPicture.asset(
                        'assets/decoration.svg',
                        width: decoratorWidth,
                      ),
                    ),
                  ),
                  Positioned(
                    right: -outDecoratorWith / 2,
                    child: Transform.rotate(
                      angle: _animatedAngle.value,
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
                                textOffset: Offset(
                                  -100,
                                  10.0 - (30 * (index / itemsCount)),
                                ),
                                option: _options[index],
                              );
                            },
                          ),
                        ],
                      ),
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
  final Offset offset, textOffset;
  final MenuOption option;
  const MenuItem({
    Key? key,
    required this.offset,
    required this.textOffset,
    required this.option,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: offset,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform.translate(
            offset: textOffset,
            child: SizedBox(
                width: 100.0,
                child: Text(
                  option.label,
                  textAlign: TextAlign.right,
                )),
          ),
          CupertinoButton(
            child: Container(
              height: 50,
              width: 50,
              child: Center(
                child: Icon(
                  option.iconData,
                  color: Colors.white,
                ),
              ),
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
