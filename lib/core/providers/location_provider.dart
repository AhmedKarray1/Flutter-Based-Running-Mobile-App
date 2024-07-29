import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/location_data.dart';
import '../services/location_service.dart';

final locationServiceProvider = Provider((ref) => LocationService());

final locationProvider = FutureProvider<LocationData>((ref) async {
  final locationService = ref.read(locationServiceProvider);
  return locationService.getCurrentLocation();
});

final locationStreamProvider = StreamProvider<LocationData>((ref) {
  final locationService = ref.read(locationServiceProvider);
  return locationService.locationStream();
});
