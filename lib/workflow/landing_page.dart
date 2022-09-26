import 'package:acme/workflow/home/screens/homepage.dart';
import 'package:acme/workflow/sign_in/screens/sign_in_screen.dart';
import 'package:acme/workflow/sign_in/view_model/user_respository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserRepository.instance(),
      child: Consumer(
        builder: (context, UserRepository user, _) {
          // redirect to page whether user is signed in or not
          switch (user.status) {
            case Status.unauthenticated:
              return const SignInScreen();
            case Status.authenticated:
              return const HomepageScreen();
          }
        },
      ),
    );
  }
}
