import 'package:acme/ui/app_color.dart';
import 'package:acme/util/enums.dart';
import 'package:acme/workflow/home/screens/tracker_grids_widget.dart';
import 'package:acme/workflow/home/view_models/home_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({Key? key}) : super(key: key);

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  final homRepo = HomeRepository();
  @override
  void initState() {
    // initially fetch the trackers value for today
    homRepo.initializeTrackers();
    super.initState();
  }

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
              ChangeNotifierProvider(
                create: (_) => homRepo,
                child: Consumer(
                  builder: (context, HomeRepository homeVm, _) {
                    // while fetching trackers we maintain 3 states
                    switch (homeVm.baseModelState) {
                      case BaseModelState.loading:
                        return const TrackerGridsLoading();
                      case BaseModelState.success:
                        return TrackerGrids(homeRepo: homeVm);
                      case BaseModelState.error:
                        return Container();
                    }
                  },
                ),
              ),
            ]),
          ),
        )
      ]),
    ));
  }
}

// a custom shimmer loading like this is used to display while the data loads
class TrackerGridsLoading extends StatelessWidget {
  const TrackerGridsLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: 4,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
            baseColor: AppColors.primaryLight,
            highlightColor: Colors.grey[800]!,
            child: const Card());
      },
    );
  }
}
