import 'package:acme/ui/app_color.dart';
import 'package:acme/workflow/sign_in/view_model/user_respository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({Key? key}) : super(key: key);

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        body: SafeArea(
      child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(
                    user!.photoURL!,
                  ),
                )),
            const SizedBox(
              height: 32,
            ),
            Text('Welcome Back'),
            Text(
              user.displayName ?? '',
              style: textTheme.headline6?.copyWith(color: AppColors.accent),
            )
          ]),
    ));
  }
}
