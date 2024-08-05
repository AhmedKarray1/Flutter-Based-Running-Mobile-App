import 'package:running_app/core/models/location_data.dart';

class LocationState {
  LocationState({
    this.locationData,
    this.isLocationReady = false,
    this.path = const [],
    this.isRecording = false,
    this.elapsedTime = 0,
  });

  final LocationData? locationData;
  final bool isLocationReady;
  final List<LocationData> path;
  final bool isRecording;
  final int elapsedTime;

  LocationState copyWith({
    LocationData? locationData,
    bool? isLocationReady,
    List<LocationData>? path,
    bool? isRecording,
    int? elapsedTime,
  }) {
    return LocationState(
      locationData: locationData ?? this.locationData,
      isLocationReady: isLocationReady ?? this.isLocationReady,
      path: path ?? this.path,
      isRecording: isRecording ?? this.isRecording,
      elapsedTime: elapsedTime ?? this.elapsedTime,
    );
  }
}
