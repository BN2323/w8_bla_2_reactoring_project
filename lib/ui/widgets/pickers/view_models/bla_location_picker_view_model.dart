import 'package:blabla/data/repositories/location/location_repository.dart';
import 'package:blabla/model/ride/locations.dart';
import 'package:flutter/material.dart';

class BlaLocationPickerViewModel extends ChangeNotifier {
  final LocationRepository repository;

  List<Location> _allLocations = [];
  String _search = "";

  BlaLocationPickerViewModel(this.repository);

  List<Location> get filteredLocations {
    if (_search.length < 2) return [];

    return _allLocations.where((location) {
      return location.name.toUpperCase().contains(_search.toUpperCase());
    }).toList();
  }

  Future<void> loadLocations() async {
    _allLocations = await repository.getLocations();
    notifyListeners();
  }

  void updateSearch(String search) {
    _search = search;
    notifyListeners();
  }
}
