import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:vpma_nagpur/utils/constants.dart';

class CustomButtonWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onTap;
  final Color color;
  const CustomButtonWidget(
      {super.key,
      required this.title,
      this.icon = EvaIcons.info,
      required this.onTap,
      this.color = kPrimaryColor});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(8.0),
      color: color,
      child: InkWell(
        onTap: onTap(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: kButtonTextStyle,
              ),
              SizedBox(
                width: 8.0,
              ),
              Icon(
                icon,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
