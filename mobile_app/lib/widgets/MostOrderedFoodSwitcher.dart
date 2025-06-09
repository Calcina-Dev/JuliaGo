import 'dart:math';
import 'package:flutter/material.dart';

class FlipCardWrapper extends StatefulWidget {
  final Widget front;
  final Widget back;
  final double height;
  final double width;

  const FlipCardWrapper({
    super.key,
    required this.front,
    required this.back,
    required this.height,
    required this.width,
  });

  @override
  State<FlipCardWrapper> createState() => _FlipCardWrapperState();
}

class _FlipCardWrapperState extends State<FlipCardWrapper>
    with TickerProviderStateMixin {
  bool _showFront = true;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _animation = Tween<double>(begin: 0, end: pi).animate(_controller);
  }

  void _flip() {
    if (_showFront) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    setState(() {
      _showFront = !_showFront;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _flip,
      child: SizedBox(
        height: widget.height,
        width: widget.width,
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            final isUnder = (_animation.value > pi / 2);
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(_animation.value),
              child: isUnder
                  ? Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(pi),
                      child: widget.back,
                    )
                  : widget.front,
            );
          },
        ),
      ),
    );
  }
}
