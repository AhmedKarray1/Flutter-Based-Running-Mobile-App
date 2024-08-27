import 'package:flutter/material.dart';
import 'package:health/health.dart';
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

  Future<PermissionStatus> getLocationlocationPermissionStatus() {
    return Permission.location.status;
  }

  Future<bool> requestActivityRecognitionPermission() async {
    var status = await Permission.activityRecognition.status;
    print('first stqatus in service is $status');

    if (status.isPermanentlyDenied || status.isDenied) {
      status = await Permission.activityRecognition.request();
    }
    print('after request $status');
    bool hasPermissions = await Health().hasPermissions(
            [HealthDataType.STEPS, HealthDataType.ACTIVE_ENERGY_BURNED],
            permissions: [HealthDataAccess.READ, HealthDataAccess.READ]) ??
        false;
    bool authorized = false;
    if (!hasPermissions) {
      try {
        authorized = await Health().requestAuthorization(
            [HealthDataType.STEPS, HealthDataType.ACTIVE_ENERGY_BURNED],
            permissions: [HealthDataAccess.READ, HealthDataAccess.READ]);
      } catch (error) {
        debugPrint("Exception in authorize: $error");
      }
    }
    if (authorized) {

    var now = DateTime.now();
       List<HealthDataPoint> healthData =


        await Health().getHealthDataFromTypes(startTime: now.subtract(const Duration(days: 4)), endTime: now, types: [HealthDataType.STEPS, HealthDataType.ACTIVE_ENERGY_BURNED]);
   
  for (var dataPoint in healthData) {
    print('Type: ${dataPoint.type}');
    print('Value: ${dataPoint.value}');
    print('Unit: ${dataPoint.unit}');
    print('Date: ${dataPoint.dateFrom} to ${dataPoint.dateTo}');
    print('Source: ${dataPoint.sourceId}');
    print('-----');
  }





    }
    print('last authorized is $authorized');

  
    return authorized;
  }
}
