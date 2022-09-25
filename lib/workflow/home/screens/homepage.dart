import 'package:acme/ui/app_color.dart';
import 'package:acme/workflow/home/widgets/tracker_box_template.dart';
import 'package:acme/workflow/trackers/screens/tracker_list_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

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
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(
                    user!.photoURL!,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                const Text('Welcome Back'),
                Text(
                  user.displayName ?? '',
                  style: textTheme.headline6?.copyWith(color: AppColors.accent),
                ),
              ],
            )),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
                color: AppColors.primaryMedium,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16))),
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: 24,
              ),
              Text(
                'My trackers',
                style: textTheme.bodyText2?.copyWith(color: AppColors.white),
              ),
              const SizedBox(
                height: 24,
              ),
              GridView(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                children: [
                  TrackerTemplate(
                    centerWidget: Image.asset(
                      'assets/trackers/weight.png',
                      width: 42,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const TrackerListHomeScreen()),
                      );
                    },
                    title: 'Weight',
                    iconData: Ionicons.scale_outline,
                    data: '52 Kg',
                  ),
                  TrackerTemplate(
                    centerWidget: Image.asset(
                      'assets/trackers/heart_rate.png',
                      width: 42,
                      color: AppColors.primary,
                    ),
                    onPressed: () {},
                    color: AppColors.accent,
                    iconColor: AppColors.primary,
                    title: 'Heart',
                    iconData: Ionicons.heart,
                    data: '72 bpm',
                  ),
                  TrackerTemplate(
                    centerWidget: Image.asset(
                      'assets/trackers/bp.png',
                      width: 62,
                    ),
                    onPressed: () {},
                    title: 'Blood pressure',
                    iconData: Ionicons.heart_circle_outline,
                    data: '90/60 mmHg',
                  ),
                  TrackerTemplate(
                    centerWidget: Image.asset(
                      'assets/trackers/exercise.png',
                      width: 42,
                    ),
                    onPressed: () {},
                    title: 'Daily Exercise',
                    iconData: Ionicons.barbell,
                    data: '30 mins',
                  ),
                ],
              )
            ]),
          ),
        )
      ]),
    ));
  }
}
