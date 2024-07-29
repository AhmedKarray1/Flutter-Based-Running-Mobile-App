import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  Future<bool> requestLocationPermission() async {
    var status = await Permission.location.status;

    if (status.isPermanentlyDenied || status.isDenied) {
      status = await Permission.locationWhenInUse.request();
    }

    return status.isGranted;
  }

  Future<PermissionStatus> getLocationPermissionStatus() {
    return Permission.location.status;
  }
}
