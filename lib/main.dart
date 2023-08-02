import 'package:flutter/material.dart';
import 'package:vpma_nagpur/screens/candidate_page/candidate_page.dart';
import 'package:vpma_nagpur/screens/login/login_page.dart';
import 'package:vpma_nagpur/utils/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vidarbha Plywood Merchant\'s Association',
      theme: ThemeData(
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            fontFamily: 'ProductSans',
            color: kPrimaryFontColor,
          ),
          bodyMedium: TextStyle(
            fontFamily: 'ProductSans',
            color: kPrimaryFontColor,
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(
              isNotAdmin: true,
            ),
        '/member/': (context) => CandidatePage(),
        // '/admin/': (context) => AdminPage(),
        // '/admin/vpma-admin/': (context) => AdminPanel(),
      },
    );
  }
}
