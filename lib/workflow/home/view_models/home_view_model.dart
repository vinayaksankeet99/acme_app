import 'package:acme/util/enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class HomeRepository with ChangeNotifier {
  BaseModelState baseModelState = BaseModelState.loading;
  String? weight;
  String? bloodPressure;
  String? dailyExercise;

  // we fetch all trackers for homescreen for today
  Future<void> initializeTrackers() async {
    baseModelState = BaseModelState.loading;
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      notifyListeners();
    });
    try {
      final result = (await FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('tracker_data')
              .doc(DateFormat('dd-MM-yyyy')
                  .format(DateTime.now())) // to fetch trackers for today
              .get())
          .data();
      weight = result?['weight'];
      bloodPressure = result?['blood_pressure'];
      dailyExercise = result?['daily_exercise'];
      baseModelState = BaseModelState.success;
      notifyListeners();
    } catch (e) {
      baseModelState = BaseModelState.error;
      notifyListeners();
    }
  }
}


// CLOUD FIRESTORE STRUCTURE

// users --> uid --> tracker_data --> dateList (in format dd-MM-yyyy) --> data
// data format is:
// {
//    blood_pressure: x (String)
//    daily_exercise: x (String)
//    date: x (TimeStamp)
//    weight x (String)
// }