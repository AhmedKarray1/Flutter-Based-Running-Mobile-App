import 'package:flutter/material.dart';
import 'package:health/health.dart';
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

  Future<bool> requestActivityRecognitionPermission() async {
    var status = await Permission.activityRecognition.status;
    print("Activity Recognition Status: $status");

    if (status.isPermanentlyDenied || status.isDenied) {
      status = await Permission.activityRecognition.request();
    }
    bool hasPermissions =
        await Health().hasPermissions([HealthDataType.STEPS,HealthDataType.ACTIVE_ENERGY_BURNED], permissions: [HealthDataAccess.READ,HealthDataAccess.READ]) ?? false;
    bool authorized = false;
    if (!hasPermissions) {
      try {
        authorized = await Health().requestAuthorization([HealthDataType.STEPS,HealthDataType.ACTIVE_ENERGY_BURNED], permissions: [HealthDataAccess.READ,HealthDataAccess.READ]);
      } catch (error) {
        debugPrint("Exception in authorize: $error");
      }
    }
    print("Authorized: $authorized");
    return status.isGranted;
  }
}
