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

  Future<void> loadPermissionStatus() async {
    final isGranted = await sharedPreferencesService.getLocationPermission();

    state = state.copyWith(isLocationPermissionGranted: isGranted);
  }

  Future<void> setLocationPermission() async {
    final permissionStatus = await permissionService.getLocationPermissionStatus();
    final isPermissionGranted = permissionStatus == PermissionStatus.granted;

    if (permissionStatus == PermissionStatus.permanentlyDenied) {
      openAppSettings();
    }

    state = state.copyWith(
      isLocationPermissionGranted: isPermissionGranted,
    );
    await sharedPreferencesService.setLocationPermission(isPermissionGranted);
  }

  Future<void> requestPermission() async {
    final didGivePermission = await permissionService.requestLocationPermission();
    state = state.copyWith(isLocationPermissionGranted: didGivePermission);
    await sharedPreferencesService.setLocationPermission(didGivePermission);
  }
}
