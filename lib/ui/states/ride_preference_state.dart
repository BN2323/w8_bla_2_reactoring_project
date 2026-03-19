import 'package:blabla/data/repositories/ride_preference/ride_preference_repository.dart';
import 'package:blabla/model/ride_pref/ride_pref.dart';
import 'package:flutter/material.dart';

class RidePreferenceState extends ChangeNotifier {
  final RidePreferenceRepository repository;

  RidePreference? _currentPreference;
  List<RidePreference> _history = [];

  RidePreferenceState(this.repository);

  RidePreference? get current => _currentPreference;
  List<RidePreference> get history => List.unmodifiable(_history);

  Future<void> loadHistory() async {
    _history = await repository.getHistory();
    notifyListeners();
  }

  void selectPreference(RidePreference preference) {
    if (_currentPreference != preference) {
      _currentPreference = preference;

      if (!_history.contains(preference)) {
        _history.insert(0, preference);
      }

      notifyListeners();
    }
  }
}
