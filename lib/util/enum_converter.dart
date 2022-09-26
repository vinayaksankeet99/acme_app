import 'package:acme/util/enums.dart';

mixin EnumConverter {
  String getTrackerNameShort(HealthTracker healthTracker) {
    switch (healthTracker) {
      case HealthTracker.weight:
        return 'weight';
      case HealthTracker.bloodPresuure:
        return 'blood pressure';
      case HealthTracker.dailyExercise:
        return 'daily exercise';
    }
  }

  String getTrackerTitle(HealthTracker healthTracker) {
    switch (healthTracker) {
      case HealthTracker.weight:
        return 'Weight Trakcer';
      case HealthTracker.bloodPresuure:
        return 'Blood Pressure Tracker';
      case HealthTracker.dailyExercise:
        return 'Daily Exercise Tracker';
    }
  }

  String getTrackerUnit(HealthTracker healthTracker) {
    switch (healthTracker) {
      case HealthTracker.weight:
        return 'Kg';
      case HealthTracker.bloodPresuure:
        return 'mmHg';
      case HealthTracker.dailyExercise:
        return 'mins';
    }
  }
}
