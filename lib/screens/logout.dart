import 'package:flutter/material.dart';
import 'package:vpma_nagpur/screens/candidate_page/candidate_page.dart';
import 'package:vpma_nagpur/screens/login/login_page.dart';

class Logout extends StatelessWidget {
  final bool isAdmin;
  const Logout({super.key, this.isAdmin = false});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vidarbha Plywood Merchant\'s Association',
      initialRoute: isAdmin ? '/admin/' : '/',
      routes: {
        '/': (context) => LoginPage(),
        '/member/': (context) => CandidatePage(),
        // '/admin/': (context) => AdminPage(),
        // '/admin/vpma-admin/': (context) => AdminPanel(),
      },
    );
  }
}
