import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:running_app/core/states/permission_state.dart';
import '../services/permission_service.dart';
import '../services/shared_preferences.dart';

class PermissionViewmodel extends StateNotifier<PermissionState> {
  PermissionViewmodel(
    this.permissionService,
    this.sharedPreferencesService,
  ) : super(const PermissionState());

  final PermissionService permissionService;
  final SharedPreferencesService sharedPreferencesService;

  Future<void> getLocationPermission() async {
    final locationPermissionStatus =
        await permissionService.getLocationlocationPermissionStatus();

    state = state.copyWith(
      locationPermissionStatus: locationPermissionStatus,
    );
  }

  Future<void> requestLocationPermission() async {
    final locationPermissionStatus =
        await permissionService.requestLocationPermission();
    state = state.copyWith(locationPermissionStatus: locationPermissionStatus);
  }

  Future<void> requestActivityRecognitionPermission() async {
    final didGivehealthPermission =
        await permissionService.requestActivityRecognitionPermission();
    if (didGivehealthPermission) {
      state = state.copyWith(healthPermissionStatus: PermissionStatus.granted);
    }
  }
}
