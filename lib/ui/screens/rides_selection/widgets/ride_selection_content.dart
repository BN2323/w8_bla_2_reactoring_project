import 'package:blabla/model/ride/ride.dart';
import 'package:blabla/model/ride_pref/ride_pref.dart';
import 'package:blabla/ui/screens/rides_selection/view_models/ride_selection_view_model.dart';
import 'package:blabla/ui/screens/rides_selection/widgets/ride_preference_modal.dart';
import 'package:blabla/ui/screens/rides_selection/widgets/rides_selection_header.dart';
import 'package:blabla/ui/screens/rides_selection/widgets/rides_selection_tile.dart';
import 'package:blabla/ui/theme/theme.dart';
import 'package:blabla/utils/animations_util.dart';
import 'package:flutter/material.dart';

class RideSelectionContent extends StatelessWidget {
  final RideSelectionViewModel vm;
  const RideSelectionContent({super.key, required this.vm});

  void onBackTap(BuildContext context) {
    Navigator.pop(context);
  }

  void onFilterPressed() {
    // TODO
  }

  void onRideSelected(Ride ride) {
    // Later
  }

  RidePreference get selectedRidePreference =>
      vm.selectedPreference!; // not null at this state

  void onPreferencePressed(BuildContext context) async {
    // 1 - Navigate to the rides preference picker
    RidePreference? newPreference = await Navigator.of(context)
        .push<RidePreference>(
          AnimationUtils.createRightToLeftRoute(
            RidePreferenceModal(initialPreference: selectedRidePreference),
          ),
        );

    if (newPreference != null) {
      // 2 - Ask the service to update the current preference
      vm.selectPreference(newPreference);


    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: BlaSpacings.m,
          right: BlaSpacings.m,
          top: BlaSpacings.s,
        ),
        child: Column(
          children: [
            RideSelectionHeader(
              ridePreference: selectedRidePreference,
              onBackPressed: () => onBackTap(context),
              onFilterPressed: onFilterPressed,
              onPreferencePressed: () => onPreferencePressed(context),
            ),

            SizedBox(height: 100),

            Expanded(
              child: ListView.builder(
                itemCount: vm.matchingRides.length,
                itemBuilder: (ctx, index) => RideSelectionTile(
                  ride: vm.matchingRides[index],
                  onPressed: () => onRideSelected(vm.matchingRides[index]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
