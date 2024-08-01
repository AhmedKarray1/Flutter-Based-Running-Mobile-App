import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:running_app/core/states/permission_state.dart';
import '../services/permission_service.dart';

class PermissionViewmodel extends StateNotifier<PermissionState> {
  PermissionViewmodel(this.permissionService) : super(PermissionState());

  final PermissionService permissionService;

  Future<void> checkLocationPermission() async {
    final permissionStatus = await permissionService.getLocationPermissionStatus();
    state = state.copyWith(
      isLocationPermissionGranted: permissionStatus == PermissionStatus.granted,
    );
  }

  Future<void> requestPermission() async {
    final didGivePermission = await permissionService.requestLocationPermission();
    state = state.copyWith(isLocationPermissionGranted: didGivePermission);
  }
}
