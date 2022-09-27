import 'package:acme/ui/app_color.dart';
import 'package:acme/util/enums.dart';
import 'package:acme/workflow/home/view_models/home_view_model.dart';
import 'package:acme/workflow/home/widgets/tracker_box_template.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

// widget to show list of trackers in grid
class TrackerGrids extends StatefulWidget {
  final HomeRepository homeRepo;
  const TrackerGrids({Key? key, required this.homeRepo}) : super(key: key);

  @override
  State<TrackerGrids> createState() => _TrackerGridsState();
}

class _TrackerGridsState extends State<TrackerGrids> {
  // we use templates with dynamic screens depending upon the tracker ENUM --> HealthTracker
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () async {
          // we use a refresh indicator to re-fetch the tracker data for today
          widget.homeRepo.initializeTrackers();
        },
        child: GridView(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
          ),
          children: [
            // a custom tracker template box is created where we can provide data and it can dynamically
            // show the boxes

            // to add a new tracker, just add a new trackertemplate as well as a new enum in HealthTracker
            TrackerTemplate(
              centerWidget: Image.asset(
                'assets/trackers/weight.png',
                width: 42,
              ),
              healthTracker: HealthTracker.weight,
              title: 'Weight',
              iconData: Ionicons.scale_outline,
              homeVM: widget.homeRepo,
              data: widget.homeRepo.weight,
            ),
            // dummy tracker
            TrackerTemplate(
              centerWidget: Image.asset(
                'assets/trackers/heart_rate.png',
                width: 42,
                color: AppColors.primary,
              ),
              healthTracker: HealthTracker.weight,
              color: AppColors.accent,
              iconColor: AppColors.primary,
              homeVM: widget.homeRepo,
              title: 'Heart',
              tappable: false,
              iconData: Ionicons.heart,
              data: '72 bpm',
            ),
            TrackerTemplate(
              centerWidget: Image.asset(
                'assets/trackers/bp.png',
                width: 62,
              ),
              homeVM: widget.homeRepo,
              healthTracker: HealthTracker.bloodPresuure,
              title: 'Blood pressure',
              iconData: Ionicons.heart_circle_outline,
              data: widget.homeRepo.bloodPressure,
            ),
            TrackerTemplate(
              centerWidget: Image.asset(
                'assets/trackers/exercise.png',
                width: 42,
              ),
              healthTracker: HealthTracker.dailyExercise,
              title: 'Daily Exercise',
              iconData: Ionicons.barbell,
              homeVM: widget.homeRepo,
              data: widget.homeRepo.dailyExercise,
            ),
          ],
        ));
  }
}
