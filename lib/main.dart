import 'package:acme/workflow/landing_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const AcmeApp());
}

class AcmeApp extends StatelessWidget {
  const AcmeApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LandingPage(),
    );
  }
}
