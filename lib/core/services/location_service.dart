import 'package:geolocator/geolocator.dart';
import '../models/location_data.dart';

class LocationService {
  Future<LocationData> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    return LocationData(
      latitude: position.latitude,
      longitude: position.longitude,
    );
  }

  Stream<LocationData> locationStream() {
    return Geolocator.getPositionStream().map((position) => LocationData(
          latitude: position.latitude,
          longitude: position.longitude,
        ));
  }
}
