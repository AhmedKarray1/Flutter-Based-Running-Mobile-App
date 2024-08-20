import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  Future<PermissionStatus> requestLocationPermission() async {
    print('service: Requesting permission');
    var status = await Permission.location.status;
    print('service: status: $status');

    if (status.isDenied) {
      status = await Permission.locationWhenInUse.request();
      print('entering isDenied');
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }

    return status;
  }

  Future<PermissionStatus> getLocationPermissionStatus() {
    return Permission.location.status;
  }
}
