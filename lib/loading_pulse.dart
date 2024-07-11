library loading_pulse;

import 'package:flutter/material.dart';
import 'dart:math';

///
///
/// It receives four parameters, a [GlobalKey<LoadingPulseState>] required and
/// 3 optional parameters
///
/// 1. [duration] duration in milliseconds [GlobalKey<LoadingPulseState>] required
/// 2. [duration] duration in milliseconds [int]
/// 3. [backgroundColor] change the background color to a custom one
/// 4. [widgetCentral] replace with a custom widget
///
/// ```dart
///   // this in your class
///  final GlobalKey<LoadingPulseState> loadingPulseKey =GlobalKey<LoadingPulseState>();
///
///  LoadingPulse(
///    key: loadingPulseKey,
///    duration: 350,
///    backgroundColor: Colors.black45,
///    widgetCentral: myCustomWidget()
///  ),
///
/// ```
///....

class LoadingPulse extends StatefulWidget {
  final Duration duration;
  final Color backgroundColor;
  final Widget? widgetCentral;

  const LoadingPulse({
    super.key,
    this.duration = const Duration(milliseconds: 350),
    this.backgroundColor = Colors.black45,
    this.widgetCentral,
  });

  @override
  LoadingPulseState createState() => LoadingPulseState();
}

class LoadingPulseState extends State<LoadingPulse>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late double maxRadius;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Calcula el radio diagonal máximo cuando el contexto esté disponible
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    maxRadius = sqrt(width * width + height * height);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void startAnimation() {
    _controller.forward();
  }

  void reverseAnimation() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final currentSize = _animation.value * maxRadius * 1;
    final borderRadius =
        BorderRadius.circular((1 - _animation.value) * currentSize / 0.8);

    return Stack(
      children: [
        Center(
          child: Container(
            width: currentSize,
            height: currentSize,
            decoration: BoxDecoration(
              color: widget.backgroundColor,
              borderRadius: borderRadius,
            ),
            child: Center(
              child: widget.widgetCentral ?? const CircularProgressIndicator(),
            ),
          ),
        ),
      ],
    );
  }
}
