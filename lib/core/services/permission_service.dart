import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  Future<PermissionStatus> requestLocationPermission() async {
    var status = await Permission.location.status;

    if (status.isDenied) {
      status = await Permission.locationWhenInUse.request();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }

    return status;
  }

  Future<PermissionStatus> getLocationPermissionStatus() {
    return Permission.location.status;
  }
}
