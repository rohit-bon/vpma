import 'package:flutter/material.dart';
import 'package:vpma_nagpur/utils/constants.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;
  final double elevation;
  final double topPadding;
  final double bottomPadding;
  final double leftPadding;
  final double rightPadding;
  final Color color;
  final Color sidesColor;
  const CustomContainer(
      {super.key,
      required this.child,
      this.elevation = 3.0,
      this.topPadding = 0.0,
      this.bottomPadding = 0.0,
      this.leftPadding = 0.0,
      this.rightPadding = 0.0,
      this.color = kThirdColor,
      this.sidesColor = kSecondaryColor});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      borderRadius: BorderRadius.circular(11.0),
      color: sidesColor,
      child: Padding(
        padding: EdgeInsets.only(
          right: rightPadding,
          left: leftPadding,
          top: topPadding,
          bottom: bottomPadding,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9.0),
            color: color,
          ),
          child: child,
        ),
      ),
    );
  }
}
