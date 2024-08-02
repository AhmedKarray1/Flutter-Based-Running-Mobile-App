import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:running_app/core/models/location_data.dart';
import 'package:running_app/core/services/location_service.dart';

import '../states/location_state.dart';

class LocationViewModel extends StateNotifier<LocationState> {
  LocationViewModel(this._locationService) : super(LocationState());

  final LocationService _locationService;

  Future<void> getCurrentLocation() async {
    final locationData = await _locationService.getCurrentLocation();
    state = state.copyWith(locationData: locationData, isLocationReady: true);
  }

  Stream<LocationData> locationStream() {
    return _locationService.locationStream();
  }
}
