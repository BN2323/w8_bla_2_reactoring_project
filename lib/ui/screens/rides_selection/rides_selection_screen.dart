import 'package:blabla/data/repositories/ride/ride_repository.dart';
import 'package:blabla/data/repositories/ride_preference/ride_preference_repository.dart';
import 'package:blabla/ui/screens/rides_selection/view_models/ride_selection_view_model.dart';
import 'package:blabla/ui/screens/rides_selection/widgets/ride_selection_content.dart';
import 'package:blabla/ui/states/ride_preference_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RidesSelectionScreen extends StatelessWidget {
  const RidesSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RidePreferenceRepository ridePreferenceRepository = context.watch<RidePreferenceRepository>();
    final RideRepository rideRepository = context.watch<RideRepository>();
    final RidePreferenceState state = RidePreferenceState(ridePreferenceRepository);
    final RideSelectionViewModel vm = RideSelectionViewModel(state, rideRepository);

    return RideSelectionContent(vm: vm);
  }
}
