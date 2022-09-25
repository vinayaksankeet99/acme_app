import 'package:acme/ui/app_color.dart';
import 'package:acme/workflow/trackers/widgets/graph_widget.dart';
import 'package:flutter/material.dart';

class TrackerListHomeScreen extends StatefulWidget {
  const TrackerListHomeScreen({Key? key}) : super(key: key);

  @override
  State<TrackerListHomeScreen> createState() => _TrackerListHomeScreenState();
}

class _TrackerListHomeScreenState extends State<TrackerListHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Weight Tracker')),
      body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          children: [
            const SizedBox(
              height: 24,
            ),
            const GraphWidget(),
            const SizedBox(
              height: 24,
            ),
            const Text('Recent weights'),
            const SizedBox(
              height: 24,
            ),
            ListTile(
              onTap: () {},
              tileColor: AppColors.primaryMedium,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              title: Text(
                'Add weight',
                style: textTheme.bodyText1?.copyWith(color: AppColors.white),
              ),
              trailing: const Text('+'),
            ),
            const SizedBox(
              height: 16,
            ),
            for (int i = 0; i < 50; i++) ...[
              ListTile(
                tileColor: AppColors.primaryLight,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                title: Text(
                  '52 kg',
                  style: textTheme.bodyText1?.copyWith(color: AppColors.white),
                ),
                trailing: Text('${i + 20}th Nov 2022'),
              ),
              const SizedBox(
                height: 16,
              )
            ],
          ]),
    );
  }
}
