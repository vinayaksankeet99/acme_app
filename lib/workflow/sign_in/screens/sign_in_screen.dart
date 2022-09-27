import 'package:acme/component/custom_elevated_button_icon.dart';
import 'package:acme/ui/app_color.dart';
import 'package:acme/workflow/sign_in/view_model/user_respository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserRepository>(context);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Spacer(),
              const Icon(
                Ionicons.diamond,
                color: AppColors.accent,
                size: 42,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                'Welcome to\nacme',
                style: textTheme.headline4?.copyWith(color: AppColors.accent),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                'Your personal health tracking app',
                style: textTheme.bodyText1,
              ),
              const Spacer(),
              CustomElevatedButtonIcon(
                  title: 'Continue with Google',
                  icon: Image.asset(
                    'assets/logos/google_logo.png',
                    width: 26,
                  ),
                  onPressed: () async {
                    await user.signInWithGoogle();
                  }),
              const SizedBox(
                height: 62,
              ),
            ],
          )),
    );
  }
}
