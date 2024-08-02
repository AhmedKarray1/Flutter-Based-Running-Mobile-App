import 'package:running_app/core/models/location_data.dart';

class LocationState {
  LocationState({
    this.locationData,
    this.isLocationReady = false,
  });

  final LocationData? locationData;
  final bool isLocationReady;

  LocationState copyWith({
    LocationData? locationData,
    bool? isLocationReady,
  }) {
    return LocationState(
      locationData: locationData ?? this.locationData,
      isLocationReady: isLocationReady ?? this.isLocationReady,
    );
  }
}
