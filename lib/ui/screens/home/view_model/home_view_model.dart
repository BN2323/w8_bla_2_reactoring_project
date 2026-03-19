import 'package:blabla/model/ride_pref/ride_pref.dart';
import 'package:blabla/ui/states/ride_preference_state.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  final RidePreferenceState ridePreferenceState;

  HomeViewModel({required this.ridePreferenceState}) {
    // Listen to global state changes
    ridePreferenceState.addListener(notifyListeners);
  }

  RidePreference? get selectedPreference =>
      ridePreferenceState.current;
  List<RidePreference> get preferenceHistory => ridePreferenceState.history;

  void selectPreference(RidePreference preference) {
    ridePreferenceState.selectPreference(preference);
    
  }

  @override
  void dispose() {
    ridePreferenceState.removeListener(notifyListeners);
    super.dispose();
  }
}
