import 'package:acme/firebase_options.dart';
import 'package:acme/ui/app_theme.dart';
import 'package:acme/workflow/landing_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const AcmeApp());
}

class AcmeApp extends StatelessWidget {
  const AcmeApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      // custom app theme data
      theme: AppTheme.getThemeData(context),
      home: const LandingPage(),
    );
  }
}
