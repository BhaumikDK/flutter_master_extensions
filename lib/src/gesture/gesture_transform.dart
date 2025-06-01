import 'package:flutter/material.dart';

class TranslateOnClick extends StatefulWidget {
  final Widget child;

  const TranslateOnClick({super.key, required this.child});

  @override
  TranslateOnClickState createState() => TranslateOnClickState();
}

class TranslateOnClickState extends State<TranslateOnClick> {
  final nonClickTransform = Matrix4.identity();
  final clickTransform = Matrix4.identity()..translate(0, -10, 0);

  bool _clicking = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (d) => _userClick(true),
      onTapUp: (d) => _userClick(false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: _clicking ? clickTransform : nonClickTransform,
        child: widget.child,
      ),
    );
  }

  void _userClick(bool click) {
    setState(() {
      _clicking = click;
    });
  }
}
