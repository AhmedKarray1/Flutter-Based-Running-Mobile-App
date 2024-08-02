import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static const String _permissionKey = 'locationPermissionGranted';

  Future<bool> getLocationPermission() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_permissionKey) ?? false;
  }

  Future<void> setLocationPermission(bool granted) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_permissionKey, granted);
  }
}
