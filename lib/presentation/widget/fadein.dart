import 'package:flutter/material.dart';

class FadeInWidget extends StatefulWidget {
  final Widget child;
  const FadeInWidget({super.key, required this.child});

  @override
  State<FadeInWidget> createState() => _FadeInWidgetState();
}

class _FadeInWidgetState extends State<FadeInWidget> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    // Delay sedikit supaya animasi dimulai setelah build
    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity,
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut,
      child: widget.child,
    );
  }
}
