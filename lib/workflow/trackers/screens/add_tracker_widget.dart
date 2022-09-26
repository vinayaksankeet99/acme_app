import 'package:acme/component/custom_elevated_button.dart';
import 'package:acme/component/custom_elevated_button_icon.dart';
import 'package:acme/ui/app_color.dart';
import 'package:acme/util/enum_converter.dart';
import 'package:acme/workflow/trackers/view_models/tracker_vm.dart';
import 'package:flutter/material.dart';

import 'package:acme/util/enums.dart';
import 'package:horizontal_picker/horizontal_picker.dart';

class AddTrackerWidget extends StatefulWidget {
  final HealthTracker healthTracker;
  final Function() added;
  const AddTrackerWidget(
      {Key? key, required this.healthTracker, required this.added})
      : super(key: key);

  @override
  State<AddTrackerWidget> createState() => _AddTrackerWidgetState();
}

class _AddTrackerWidgetState extends State<AddTrackerWidget>
    with EnumConverter {
  List<double> getTrackerMinMaxValues(HealthTracker tracker) {
    switch (tracker) {
      case HealthTracker.weight:
        return [20, 120];
      case HealthTracker.bloodPresuure:
        return [50, 250];
      case HealthTracker.dailyExercise:
        return [20, 90];
    }
  }

  String? currentValue;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        const SizedBox(
          height: 32,
        ),
        Text(
          'Enter ${getTrackerNameShort(widget.healthTracker)}',
          style: textTheme.headline5,
        ),
        const SizedBox(
          height: 32,
        ),
        Text(
          'in ${getTrackerUnit(widget.healthTracker)}',
          style: textTheme.titleSmall,
        ),
        const SizedBox(
          height: 12,
        ),
        HorizontalPicker(
          minValue: getTrackerMinMaxValues(widget.healthTracker)[0],
          // these are dollars
          maxValue: getTrackerMinMaxValues(widget.healthTracker)[1],
          // these are dollars
          divisions: (getTrackerMinMaxValues(widget.healthTracker)[1] -
                  getTrackerMinMaxValues(widget.healthTracker)[0])
              .round(),
          onChanged: (value) {
            setState(() {
              currentValue = '$value ${getTrackerUnit(widget.healthTracker)}';
            });
          },
          height: 120,
        ),
        const Spacer(),
        CustomElevatedButton(
            color: AppColors.accent,
            onPressed: currentValue == null
                ? null
                : () async {
                    await TrackerVM()
                        .updateTracker(widget.healthTracker, currentValue!);
                    widget.added();
                  },
            title: 'SAVE'),
        const SizedBox(
          height: 32,
        )
      ],
    );
  }
}
