import 'package:flutter/material.dart';
import 'package:vpma_nagpur/utils/constants.dart';

class CustomFloatingButton extends StatelessWidget {
  final IconData? icon;
  final Function? onTap;
  final String? tooltip;
  const CustomFloatingButton({super.key, this.icon, this.onTap, this.tooltip});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      verticalOffset: 30.0,
      message: tooltip,
      child: RawMaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        constraints: BoxConstraints(maxHeight: 38.0, maxWidth: 38.0),
        fillColor: kSecondaryColor,
        onPressed: onTap!(),
        elevation: 2.0,
        child: Center(
          child: Icon(
            icon,
            color: Colors.white,
            size: 25.0,
          ),
        ),
      ),
    );
  }
}
