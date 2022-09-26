import 'package:acme/ui/app_color.dart';
import 'package:acme/util/enums.dart';
import 'package:acme/workflow/home/view_models/home_view_model.dart';
import 'package:acme/workflow/trackers/screens/add_tracker_widget.dart';
import 'package:acme/workflow/trackers/screens/tracker_list_home.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class TrackerTemplate extends StatefulWidget {
  final String title;
  final HealthTracker healthTracker;
  final IconData iconData;
  final Widget centerWidget;
  final String? data;
  final Color color;
  final Color? iconColor;
  final HomeRepository homeVM;
  const TrackerTemplate({
    Key? key,
    required this.title,
    required this.iconData,
    required this.centerWidget,
    required this.healthTracker,
    required this.data,
    required this.homeVM,
    this.color = AppColors.primaryLight,
    this.iconColor = AppColors.white,
  }) : super(key: key);

  @override
  State<TrackerTemplate> createState() => _TrackerTemplateState();
}

class _TrackerTemplateState extends State<TrackerTemplate> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    // open container is used for open/close animation.
    return OpenContainer<String>(
      transitionDuration: const Duration(milliseconds: 400),
      closedColor: widget.color,
      openColor: AppColors.primary,
      // the screen that appears when you tap on the widget
      openBuilder: (_, closeContainer) => TrackerListHomeScreen(
        healthTracker: widget.healthTracker,
      ),
      closedShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      tappable: true,
      // the widget that appears on home screen
      closedBuilder: (_, openContainer) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  widget.iconData,
                  size: 16,
                  color: widget.iconColor,
                ),
                const SizedBox(
                  width: 12,
                ),
                Text(widget.title)
              ],
            ),
            // if tracker data exists, we show the data else add widget
            if (widget.data != null) ...[
              const Spacer(),
              Align(alignment: Alignment.center, child: widget.centerWidget),
              const Spacer(),
              Text(
                widget.data!,
                style: textTheme.bodyText2
                    ?.copyWith(fontSize: 16, color: widget.iconColor),
              )
            ] else ...[
              const Spacer(),
              Align(
                alignment: Alignment.center,
                child: InkWell(
                    borderRadius: BorderRadius.circular(60),
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return AddTrackerWidget(
                              healthTracker: widget.healthTracker,
                              added: () {
                                Navigator.pop(context);
                                widget.homeVM.initializeTrackers();
                              },
                            );
                          });
                    },
                    child: const Icon(
                      Ionicons.add_circle,
                      color: AppColors.white,
                      size: 52,
                    )),
              ),
              const SizedBox(
                height: 16,
              ),
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Add',
                    textAlign: TextAlign.center,
                    style: textTheme.bodyText2
                        ?.copyWith(fontSize: 16, color: widget.iconColor),
                  )),
              const Spacer(),
            ]
          ],
        ),
      ),
    );
  }
}
