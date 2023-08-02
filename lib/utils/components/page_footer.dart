import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:vpma_nagpur/utils/constants.dart';

class PageFooter extends StatelessWidget {
  const PageFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 24.0),
        Row(
          children: [
            Expanded(
              child: Container(),
            ),
            Image.asset(
              'assets/images/vpma_logo.png',
              height: 60.0,
              fit: BoxFit.fitHeight,
            ),
            const Text(
              'Vidarbha Plywood\nMerchant\'s Association',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Ubuntu',
                fontSize: 20.0,
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(0, 3),
                    blurRadius: 4.0,
                    color: Color.fromARGB(90, 0, 0, 0),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(),
            ),
          ],
        ),
        const SizedBox(height: 18.0),
        Row(
          children: [
            Expanded(
              child: Text(
                '2nd Floor, Shyama Arcade, 55, Old Bagadganj\nNear Baba Nanak High School, Nagpur - 440008 (M.S)',
                textAlign: TextAlign.center,
                style: kBottomTextStyle.copyWith(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 18.0),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.mail_outline,
                    color: Colors.white,
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    'info@vpmanagpur.com',
                    style: kBottomTextStyle,
                  )
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.phone,
                    color: Colors.white,
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    '0712 - 27568223',
                    style: kBottomTextStyle,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Connect with us',
                    style: kBottomTextStyle,
                  ),
                  SizedBox(width: 12.0),
                  Icon(
                    Icons.facebook_outlined,
                    color: Colors.white,
                  ),
                  SizedBox(width: 8.0),
                  Icon(
                    Ionicons.logo_instagram,
                    color: Colors.white,
                  ),
                  SizedBox(width: 8.0),
                  Icon(
                    Ionicons.logo_twitter,
                    color: Colors.white,
                  ),
                  SizedBox(width: 8.0),
                  Icon(
                    Ionicons.logo_whatsapp,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20.0),
      ],
    );
  }
}
