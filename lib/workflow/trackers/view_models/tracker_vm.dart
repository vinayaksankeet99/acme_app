import 'package:acme/util/enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class TrackerVM with ChangeNotifier {
  BaseModelState baseModelState = BaseModelState.loading;
  List<TrackerData> trackerListData = [];
  String getTrackerString(HealthTracker healthTracker) {
    switch (healthTracker) {
      case HealthTracker.weight:
        return 'weight';
      case HealthTracker.bloodPresuure:
        return 'blood_pressure';
      case HealthTracker.dailyExercise:
        return 'daily_exercise';
    }
  }

  Future<void> getTrackerList(HealthTracker healthTracker) async {
    baseModelState = BaseModelState.loading;
    try {
      final result = (await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('tracker_data')
          .get());
      trackerListData = result.docs.map((e) {
        return TrackerData(
            data: e.data()[getTrackerString(healthTracker)] ?? '',
            date: e.data()['date'].toDate());
      }).toList();
      trackerListData.removeWhere((element) => element.data.isEmpty);
      trackerListData.sort(((a, b) {
        return b.date.compareTo(a.date);
      }));
      baseModelState = BaseModelState.success;
      notifyListeners();
    } catch (e) {
      baseModelState = BaseModelState.error;
      notifyListeners();
    }
  }

  Future<void> updateTracker(
      {required HealthTracker healthTracker,
      required String data,
      required DateTime date}) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({'last_updated': DateTime.now()});
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('tracker_data')
          .doc(DateFormat('dd-MM-yyyy').format(date))
          .set({getTrackerString(healthTracker): data, 'date': date},
              SetOptions(merge: true));
    } catch (e) {}
  }
}

class TrackerData {
  final String data;
  final DateTime date;
  const TrackerData({required this.data, required this.date});
}
