import 'package:acme/ui/app_color.dart';
import 'package:acme/util/enum_converter.dart';
import 'package:acme/util/enums.dart';
import 'package:acme/workflow/trackers/screens/add_tracker_widget.dart';
import 'package:acme/workflow/trackers/view_models/tracker_vm.dart';
import 'package:acme/workflow/trackers/widgets/graph_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

// This is a dynamic template and changes depending upon which tracker we are using
// ENUM in HealthTracker
class TrackerListHomeScreen extends StatefulWidget {
  final HealthTracker healthTracker;
  const TrackerListHomeScreen({Key? key, required this.healthTracker})
      : super(key: key);

  @override
  State<TrackerListHomeScreen> createState() => _TrackerListHomeScreenState();
}

class _TrackerListHomeScreenState extends State<TrackerListHomeScreen>
    with EnumConverter {
  final trackerRepo = TrackerVM();
  @override
  void initState() {
    // get the tracker data for all dates (will fetch only weight, BP or)
    trackerRepo.getTrackerList(widget.healthTracker);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(getTrackerTitle(widget.healthTracker))),
      body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          children: [
            const SizedBox(
              height: 24,
            ),
            GraphWidget(
              unit: getTrackerUnit(widget.healthTracker),
            ),
            const SizedBox(
              height: 24,
            ),
            Text('Recent ${getTrackerNameShort(widget.healthTracker)}'),
            const SizedBox(
              height: 24,
            ),
            ChangeNotifierProvider(
              create: (_) => trackerRepo,
              child: Consumer(
                builder: (context, TrackerVM trackerVM, _) {
                  switch (trackerVM.baseModelState) {
                    case BaseModelState.loading:
                      return const TrackerListLoading();
                    case BaseModelState.success:
                      return TrackerListWidget(
                        healthTracker: widget.healthTracker,
                        trackerVm: trackerVM,
                        trackerData: trackerVM.trackerListData,
                      );
                    case BaseModelState.error:
                      return Container();
                  }
                },
              ),
            ),
          ]),
    );
  }
}

// loading widget until trackers of all dates load
class TrackerListLoading extends StatelessWidget {
  const TrackerListLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 4,
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 16,
        );
      },
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
            baseColor: AppColors.primaryLight,
            highlightColor: Colors.grey[800]!,
            child: Container(
              height: 52,
              decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(12)),
            ));
      },
    );
  }
}

class TrackerListWidget extends StatefulWidget {
  final List<TrackerData> trackerData;
  final HealthTracker healthTracker;
  final TrackerVM trackerVm;
  const TrackerListWidget(
      {Key? key,
      required this.trackerData,
      required this.healthTracker,
      required this.trackerVm})
      : super(key: key);

  @override
  State<TrackerListWidget> createState() => _TrackerListWidgetState();
}

class _TrackerListWidgetState extends State<TrackerListWidget>
    with EnumConverter {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        // show the add button if data for today does not exist
        if (!widget.trackerData.any((element) =>
            DateFormat('dd MM yyyy').format(element.date) ==
            DateFormat('dd MM yyyy').format(DateTime.now()))) ...[
          ListTile(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return AddTrackerWidget(
                      healthTracker: widget.healthTracker,
                      added: () {
                        Navigator.pop(context);
                        widget.trackerVm.getTrackerList(widget.healthTracker);
                      },
                      dateTime: DateTime.now(),
                    );
                  });
            },
            tileColor: AppColors.primaryMedium,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            title: Text(
              'Add ${getTrackerNameShort(widget.healthTracker)}',
              style: textTheme.bodyText1?.copyWith(color: AppColors.white),
            ),
            trailing: const Text('+'),
          ),
          const SizedBox(
            height: 16,
          )
        ],

        // list of tracker data sorted according to date
        for (int index = 0; index < widget.trackerData.length; index++) ...[
          ListTile(
            tileColor: AppColors.primaryLight,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            leading: InkWell(
              child: const Icon(
                CupertinoIcons.pen,
                color: AppColors.white,
              ),
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return AddTrackerWidget(
                        healthTracker: widget.healthTracker,
                        added: () {
                          Navigator.pop(context);
                          widget.trackerVm.getTrackerList(widget.healthTracker);
                        },
                        dateTime: widget.trackerData[index].date,
                      );
                    });
              },
            ),
            minLeadingWidth: 0,
            title: Text(
              widget.trackerData[index].data,
              style: textTheme.bodyText1?.copyWith(color: AppColors.white),
            ),
            trailing: Text(DateFormat('dd MMM, yyyy')
                .format(widget.trackerData[index].date)),
          ),
          const SizedBox(
            height: 16,
          )
        ],
      ],
    );
  }
}
