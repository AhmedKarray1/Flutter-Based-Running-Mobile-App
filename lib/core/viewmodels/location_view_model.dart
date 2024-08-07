import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/location_data.dart';
import '../services/location_service.dart';
import '../states/location_state.dart';

class LocationViewModel extends StateNotifier<LocationState> {
  LocationViewModel(this._locationService) : super(LocationState());

  final LocationService _locationService;
  StreamSubscription<LocationData>? _positionSubscription;
  Timer? _timer;
  int _elapsedSeconds = 0;

  Future<void> getCurrentLocation() async {
    final locationData = await _locationService.getCurrentLocation();
    state = state.copyWith(locationData: locationData, isLocationReady: true);
  }

  void startRecording() {
    _positionSubscription = _locationService.locationStream().distinct().listen((position) {
      final locationData = LocationData(
        latitude: position.latitude,
        longitude: position.longitude,
      );
      state = state.copyWith(isRecording: true);

      _updateLocation(locationData);
    });
    _startTimer();
  }

  void stopRecording() {
    _positionSubscription?.cancel();
    _positionSubscription = null;
    state = state.copyWith(isRecording: false);
    _stopTimer();
  }

  void _startTimer() {
    _elapsedSeconds = 0;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _elapsedSeconds++;
      state = state.copyWith(elapsedTime: _elapsedSeconds);
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void _updateLocation(LocationData locationData) {
    state = state.copyWith(
      locationData: locationData,
      path: [...state.path, locationData],
      isLocationReady: true,
    );
  }
}
