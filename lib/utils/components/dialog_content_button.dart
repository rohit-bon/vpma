import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class DialogContentButton extends StatelessWidget {
  final String? title;
  final Function? onPressed;
  const DialogContentButton({
    super.key,
    this.title,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: 0.0,
      fillColor: Colors.blueGrey[900],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
      ),
      onPressed: onPressed!(),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 10.0,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              EvaIcons.image2,
              color: Colors.blueGrey[200],
            ),
            SizedBox(
              width: 5.0,
            ),
            Text(
              title!,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.blueGrey[200],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
