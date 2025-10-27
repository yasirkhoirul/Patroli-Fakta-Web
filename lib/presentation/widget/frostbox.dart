import 'dart:ui';

import 'package:flutter/material.dart';

class Frostbox extends StatelessWidget {
  final double height;
  final double width;
  final Widget child;
  const Frostbox({
    super.key,
    required this.height,
    required this.width,
    required this.child,
  });
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(12),
      child: SizedBox(
        
        height: height,
        width: width,
        child: Stack(
          children: [
            //blur
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(),
            ),
            //gradient
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white.withValues(alpha: 0.4)),
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withValues(alpha: 0.2),
                    Colors.white.withValues(alpha: 0.1),
                  ],
                ),
              ),
            ),

            //child
            child,
          ],
        ),
      ),
    );
  }
}
