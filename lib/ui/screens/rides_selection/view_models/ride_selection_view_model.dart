import 'package:blabla/data/repositories/ride/ride_repository.dart';
import 'package:blabla/model/ride/ride.dart';
import 'package:blabla/model/ride_pref/ride_pref.dart';
import 'package:blabla/ui/states/ride_preference_state.dart';
import 'package:flutter/material.dart';

class RideSelectionViewModel extends ChangeNotifier {
  final RidePreferenceState state;
  final RideRepository repository;
  List<Ride> _allRides = [];

  RideSelectionViewModel(this.state, this.repository) {
    state.addListener(notifyListeners);

    _init();
  }

  List<Ride>? get rides => _allRides;
  RidePreference? get selectedPreference => state.current;

  List<Ride> get matchingRides {
    final pref = selectedPreference;
    if (pref == null) return [];

    return _allRides.where((ride) {
      return ride.departureLocation == pref.departure &&
          ride.arrivalLocation == pref.arrival &&
          ride.availableSeats >= pref.requestedSeats;
    }).toList();
  }

  Future<void> _init() async {
    _allRides = await repository.getRides();
    notifyListeners();
  }
  void selectPreference(RidePreference pref) {
    state.selectPreference(pref);
  }

  @override
  void dispose() {
    state.removeListener(notifyListeners);
    super.dispose();
  }
}
