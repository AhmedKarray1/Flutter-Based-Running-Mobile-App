import 'package:running_app/core/models/location_data.dart';

class LocationState {
  LocationState({
    this.locationData,
    this.isLocationReady = false,
    this.path = const [],
  });

  final LocationData? locationData;
  final bool isLocationReady;
  final List<LocationData> path;

  LocationState copyWith({
    LocationData? locationData,
    bool? isLocationReady,
    List<LocationData>? path,
  }) {
    return LocationState(
      locationData: locationData ?? this.locationData,
      isLocationReady: isLocationReady ?? this.isLocationReady,
      path: path ?? this.path,
    );
  }
}
