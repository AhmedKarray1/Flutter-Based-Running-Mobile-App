import 'package:running_app/core/models/location_data.dart';

class LocationState {
  LocationState({
    this.locationData,
    this.getIt = false,
  });

  final LocationData? locationData;
  final bool getIt;

  LocationState copyWith({
    LocationData? locationData,
    bool? getIt,
  }) {
    return LocationState(
      locationData: locationData ?? this.locationData,
      getIt: getIt ?? this.getIt,
    );
  }
}
