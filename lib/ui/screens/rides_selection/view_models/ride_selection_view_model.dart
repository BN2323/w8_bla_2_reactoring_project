import 'package:blabla/data/repositories/ride/ride_repository.dart';
import 'package:blabla/model/ride/ride.dart';
import 'package:blabla/ui/states/ride_preference_state.dart';
import 'package:flutter/material.dart';

class RideSelectionViewModel extends ChangeNotifier {
  final RidePreferenceState state;
  final RideRepository repository;
  List<Ride>? _rides;

  RideSelectionViewModel(this.state, this.repository) {
    state.addListener(notifyListeners);

    _init();
  }

  List<Ride>? get rides => _rides;

  Future<void> _init() async {
    final allRides = await repository.getRides();

    final pref = state.current;
    if (pref == null) return;

   _rides = allRides.where((ride) {
      return ride.departureLocation == pref.departure &&
          ride.arrivalLocation == pref.arrival &&
          ride.availableSeats >= pref.requestedSeats;
    }).toList();

    notifyListeners();
  }


  @override
  void dispose() {
    state.removeListener(notifyListeners);
    super.dispose();
  }
}
