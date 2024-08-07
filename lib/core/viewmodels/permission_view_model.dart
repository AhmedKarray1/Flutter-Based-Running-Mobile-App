import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    final permissionStatus = await permissionService.getLocationPermissionStatus();
    print('Permission status: $permissionStatus');

    state = state.copyWith(
      permissionStatus: permissionStatus,
    );
  }

  Future<void> requestPermission() async {
    final didGivePermission = await permissionService.requestLocationPermission();
    state = state.copyWith(permissionStatus: didGivePermission);
  }
}
